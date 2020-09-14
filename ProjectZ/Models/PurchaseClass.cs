using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectZ.Models
{
    public class PurchaseClass
    {
        public int UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string City { get; set; }
        public string PostalCode { get; set; }
        public string Street { get; set; }
        public string Appartments { get; set; }
        public decimal TotalAmount { get; set; }
    }
}