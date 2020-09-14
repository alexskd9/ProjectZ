using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ProjectZ.Models.Database;

namespace ProjectZ.Models
{
    public class ProductExtended
    {
        public Product Product { get; set; }
        public bool IsFavourite { get; set; }
    }
}