﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectZ.Models
{
    public class Cart
    {
        public int CartProductId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public decimal Price { get; set; }
        public int Qty { get; set; }
    }
}