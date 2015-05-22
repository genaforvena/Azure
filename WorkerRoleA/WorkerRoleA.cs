using System;
using System.Collections.Generic;
using System.Data.Services.Client;
using System.Diagnostics;
using System.Linq;
using System.Net;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage.Table;
using MvcWebRole.Models;

namespace WorkerRoleA
{
    class taskInProcess
    {
        public Task task;
        public int parts;
    }

    public class WorkerRoleA : RoleEntryPoint
    {
        private const int steps = 10000;
        private CloudQueue tasksQueue;
        private CloudQueue solvedTasksQueue;
        private CloudTable taskTable;
        private volatile bool onStopCalled = false;
        private volatile bool returnedFromRunMethod = false;
        private Dictionary<string, taskInProcess> inProcess;

        public override void Run()
        {
            Trace.TraceInformation("WorkerRoleA entering Run()");
            while (true)
            {
                try
                {
                    // If OnStop has been called, return to do a graceful shutdown.
                    if (onStopCalled == true)
                    {
                        Trace.TraceInformation("onStopCalled WorkerRoleA");
                        returnedFromRunMethod = true;
                        return;
                    }

                    string statusFilter = TableQuery.CombineFilters(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "tasks"),
                                            TableOperators.And,
                                            TableQuery.GenerateFilterCondition("State", QueryComparisons.Equal, "Waiting"));
                    var tasksQuery = (new TableQuery<Task>().Where(statusFilter));
                    var tasks = taskTable.ExecuteQuery(tasksQuery).ToList();
                    foreach (var task in tasks)
                    {
                        var a = task.Left;
                        var b = task.Left + steps * task.Step;
                        taskInProcess t = new taskInProcess();
                        t.task = task;
                        while (b < task.Right)
                        {
                            queueTaskPart(task, a, b);
                            t.parts++;
                            a = b;
                            b += steps * task.Step;
                        }
                        queueTaskPart(task, a, task.Right - a);
                        if (a < task.Right)
                            t.parts++;
                        task.State = "In progress";
                        var updateTask = TableOperation.Replace(task);
                        taskTable.Execute(updateTask);
                        task.Result = 0;
                        inProcess.Add(task.RowKey, t);
                    }

                    var completed = solvedTasksQueue.GetMessages(32);
                    while (completed.Count() > 0)
                    {
                        foreach (var message in completed)
                        {
                            var sep = new List<char>();
                            sep.Add(';');
                            var msg = message.AsString.Split(sep.ToArray());
                            var t = inProcess[msg[0]];
                            if (t != null)
                            {
                                t.parts--;
                                t.task.Result += Convert.ToDouble(msg[1]);
                                if (t.parts == 0)
                                {
                                    inProcess.Remove(msg[0]);
                                    t.task.State = "Completed";
                                    var updateTask = TableOperation.Replace(t.task);
                                    taskTable.Execute(updateTask);
                                }
                            }
                        }
                        completed = solvedTasksQueue.GetMessages(32);
                    }

                    // Sleep for one minute to minimize query costs. 
                    System.Threading.Thread.Sleep(1000 * 10);
                }
                catch (Exception ex)
                {
                    string err = ex.Message;
                    if (ex.InnerException != null)
                    {
                        err += " Inner Exception: " + ex.InnerException.Message;
                    }
                    Trace.TraceError(err);
                    // Don't fill up Trace storage if we have a bug in queue process loop.
                    System.Threading.Thread.Sleep(1000 * 10);
                }
            }
        }

        private void queueTaskPart(Task task, double left, double right)
        {
            if (right - left <= 0)
                return;
            string taskString = task.RowKey + ";" + left + ";" + right + ";" + task.Step;
            var queueMessage = new CloudQueueMessage(taskString);
            tasksQueue.AddMessage(queueMessage);
        }

        private void ConfigureDiagnostics()
        {
            DiagnosticMonitorConfiguration config = DiagnosticMonitor.GetDefaultInitialConfiguration();
            config.ConfigurationChangePollInterval = TimeSpan.FromMinutes(1d);
            config.Logs.BufferQuotaInMB = 500;
            config.Logs.ScheduledTransferLogLevelFilter = LogLevel.Verbose;
            config.Logs.ScheduledTransferPeriod = TimeSpan.FromMinutes(1d);

            DiagnosticMonitor.Start(
                "Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString",
                config);
        }

        public override void OnStop()
        {
            onStopCalled = true;
            while (returnedFromRunMethod == false)
            {
                System.Threading.Thread.Sleep(1000);
            }
        }

        public override bool OnStart()
        {
            ServicePointManager.DefaultConnectionLimit = Environment.ProcessorCount;

            ConfigureDiagnostics();
            Trace.TraceInformation("Initializing storage account in WorkerA");
            var storageAccount = Microsoft.WindowsAzure.Storage.CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("StorageConnectionString"));

            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            tasksQueue = queueClient.GetQueueReference("tasksqueue");
            solvedTasksQueue = queueClient.GetQueueReference("solvedtasksqueue");
            var tableClient = storageAccount.CreateCloudTableClient();
            taskTable = tableClient.GetTableReference("tasks");

            // Create if not exists for queues.
            tasksQueue.CreateIfNotExists();
            solvedTasksQueue.CreateIfNotExists();
            taskTable.CreateIfNotExists();

            inProcess = new Dictionary<string, taskInProcess>();

            return base.OnStart();
        }
    }
}
