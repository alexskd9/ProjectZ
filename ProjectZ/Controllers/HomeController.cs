using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProjectZ.Models;

namespace ProjectZ.Controllers
{
    public class HomeController : DbConnectionController
    {
        // GET: Home
        public ActionResult Index()
        {
            return View(new IndexPage()
            {
                Topics = db.Topics.OrderByDescending(x => x.CreationDate).Take(6),
                Products = db.Products.Take(4)
            });
        }

        public ActionResult About()
        {
            return View();
        }
    }
}