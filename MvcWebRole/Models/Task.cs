using System.ComponentModel.DataAnnotations;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;

namespace MvcWebRole.Models
{
    public class Task : TableEntity
    {
        public Task()
        {
            this.PartitionKey = "tasks";
            State = "New";
            Step = 0.0001;
        }

        [Required]
        [Display(Name = "a")]
        public double Left
        {
            get;
            set;
        }

        [Required]
        [Display(Name = "b")]
        public double Right
        {
            get;
            set;
        }

        [Required]
        [Display(Name = "h")]
        public double Step
        {
            get;
            set;
        }

        [Display(Name = "Description")]
        public string Description 
        {
            get;
            set;
        }

        [Display(Name = "State")]
        public string State
        {
            get;
            set;
        }

        [Display(Name = "Result")]
        public double? Result
        {
            get;
            set;
        }
    }
}