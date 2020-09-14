using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectZ.Models.Product
{
    public class Product
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public int MeasureUnit { get; set; }
        public int Price { get; set; }
        public int Group { get; set; }
        public int Image { get; set; }
    }
}