using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.RetryPolicies;
using Microsoft.WindowsAzure.Storage.Table;
using MvcWebRole.Models;
using System.Diagnostics;

namespace MvcWebRole.Controllers
{
    public class TaskController : Controller
    {
        private CloudTable tasksTable;

        public TaskController()
        {
            var storageAccount = Microsoft.WindowsAzure.Storage.CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("StorageConnectionString"));
            // If this is running in a Windows Azure Web Site (not a Cloud Service) use the Web.config file:
            //    var storageAccount = Microsoft.WindowsAzure.Storage.CloudStorageAccount.Parse(ConfigurationManager.ConnectionStrings["StorageConnectionString"].ConnectionString);

            var tableClient = storageAccount.CreateCloudTableClient();
            tasksTable = tableClient.GetTableReference("tasks");
            if (!tasksTable.Exists())
            {
                throw new Exception("'tasks' table doesn't exists");
            }
        }
        //
        // GET: /Task/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Task/Create/

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Task task)
        {
            if (ModelState.IsValid)
            {
                task.State = "Waiting";
                task.RowKey = System.DateTime.Now.ToBinary().ToString();
                var insertOperation = TableOperation.Insert(task);
                tasksTable.Execute(insertOperation);
                return RedirectToAction("Index");
            }
            return View(task);
        }

        //
        // GET: /Solver/List/

        public ActionResult List()
        {
            TableRequestOptions reqOptions = new TableRequestOptions()
            {
                MaximumExecutionTime = TimeSpan.FromSeconds(1.5),
                RetryPolicy = new LinearRetry(TimeSpan.FromSeconds(3), 3)
            };
            List<Task> lists;
            try
            {
                var query = new TableQuery<Task>().Where(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "tasks"));
                lists = tasksTable.ExecuteQuery(query, reqOptions).ToList();
            }
            catch (StorageException se)
            {
                ViewBag.errorMessage = "Timeout error, try again. ";
                Trace.TraceError(se.Message);
                return View("Error");
            }
            return View(lists);
        }
    }
}
