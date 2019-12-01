using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Aqwas.Web.Models
{
    public class FeedsProvider
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public bool IsSubscribe { get; set; }
    }
}