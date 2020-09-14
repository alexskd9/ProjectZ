using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ProjectZ.Models.Database;

namespace ProjectZ.Models
{
    public class IndexPage
    {
        public IEnumerable<Topic> Topics { get; set; }
        public IEnumerable<Product> Products { get; set; }
    }
}