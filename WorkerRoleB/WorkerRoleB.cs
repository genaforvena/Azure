using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage.Table;
using MvcWebRole.Models;
using SendGridMail;
using SendGridMail.Transport;

namespace WorkerRoleB
{
    public class WorkerRoleB : RoleEntryPoint
    {

        private CloudQueue tasksQueue;
        private CloudQueue solvedTasksQueue;
        private volatile bool onStopCalled = false;
        private volatile bool returnedFromRunMethod = false;

        public override void Run()
        {
            Trace.TraceInformation("WorkerRoleB start of Run()");
            while (true)
            {
                try
                {
                    // If OnStop has been called, return to do a graceful shutdown.
                    if (onStopCalled == true)
                    {
                        Trace.TraceInformation("onStopCalled WorkerRoleB");
                        returnedFromRunMethod = true;
                        return;
                    }

                    var message = tasksQueue.GetMessage();
                    while (message != null)
                    {

                        var sep = new List<char>();
                        sep.Add(';');
                        var msg = message.AsString.Split(sep.ToArray());
                        var res = caclculate(Convert.ToDouble(msg[1]), Convert.ToDouble(msg[2]), Convert.ToDouble(msg[3]));
                        string answer = msg[0] + ";" + res.ToString();
                        var queueMessage = new CloudQueueMessage(answer);
                        solvedTasksQueue.AddMessage(queueMessage);
                        message = tasksQueue.GetMessage();
                    }
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
                    // Don't fill up Trace storage if we have a bug in either process loop.
                    System.Threading.Thread.Sleep(1000 * 10);
                }
            }
        }

        private double caclculate(double a, double b, double h)
        {
            double res = 0;
            while (a < b)
            {
                res += (Math.Sin(a) + Math.Sin(a + h)) * h / 2;
                a += h;
            }
            return res;
        }

        private void ConfigureDiagnostics()
        {
            DiagnosticMonitorConfiguration config = DiagnosticMonitor.GetDefaultInitialConfiguration();
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

            // Read storage account configuration settings
            ConfigureDiagnostics();
            Trace.TraceInformation("Initializing storage account in worker role B");
            var storageAccount = Microsoft.WindowsAzure.Storage.CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("StorageConnectionString"));

            // Initialize queue storage 
            Trace.TraceInformation("Creating queue client.");
            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            tasksQueue = queueClient.GetQueueReference("tasksqueue");
            solvedTasksQueue = queueClient.GetQueueReference("solvedtasksqueue");
            
            Trace.TraceInformation("WorkerB: Creating queues, if they don't exist.");
                        tasksQueue.CreateIfNotExists();
            solvedTasksQueue.CreateIfNotExists();

            return base.OnStart();
        }
    }
}
