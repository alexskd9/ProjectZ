using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProjectZ.Models.Database;
using ProjectZ.Helpers;
using System.Transactions;
using System.IO;
using ProjectZ.Models;

namespace ProjectZ.Controllers
{
    public class TopicController : DbConnectionController
    {
        //ყველა პოსტის ნახვა
        public ActionResult AllTopics()
        {
            if (HttpContext.User.Identity.IsAuthenticated)
            {
                ViewBag.userid = db.Users.FirstOrDefault(x => x.Email == HttpContext.User.Identity.Name).Id;
            }
            return View(db.Topics.OrderByDescending(x => x.CreationDate));
        }
        // პოსტის დამატება
        public ActionResult Add()
        {
            return View();
        }

        [HttpPost]
        //HTML ტაგების ბაზაში ჩასაწერად საჭიროა დაცვის გათიშვა
        [ValidateInput(false)]
        public ActionResult Add(Topic topic, Image image, HttpPostedFileBase imageToUpload)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                var userid = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name);
                if (imageToUpload != null)
                {
                    string fileExtension = Path.GetExtension(imageToUpload.FileName);
                    string newName = Generators.Random32();
                    string path = Server.MapPath("/Content/images/");
                    imageToUpload.SaveAs(path + newName + fileExtension);

                    image.Extension = fileExtension;
                    image.Name = newName;
                    image.Path = "/Content/images/";
                    db.Images.Add(image);
                    db.SaveChanges();

                    topic.ImageId = image.Id;
                }
                topic.CreationDate = DateTime.Now;
                topic.LastEditDate = DateTime.Now;
                topic.UserId = userid.Id;
                db.Topics.Add(topic);
                db.SaveChanges();
                transaction.Complete();
            }
            return RedirectToAction("Index", "Home");
        }

        //პოსტის სრული ვერსიის წაკითხვა
        [AllowAnonymous]
        public ActionResult Details(int id)
        {
            var topic = db.Topics.FirstOrDefault(x => x.Id == id);
            return View(new TopicWithComments()
            {
                Topic=topic,
                Comment = topic.TopicComments
            });
        }

        [HttpPost]
        public JsonResult AddComment(int topicId, string text)
        {
            int userId = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name).Id;
            var comment = new TopicComment()
            {
                UserId = userId,
                TopicId = topicId,
                Comment = text,
                CommentDate = DateTime.Now
            };
            db.TopicComments.Add(comment);
            db.SaveChanges();
            return Json(new { Comment = comment.Comment, Date = comment.CommentDate.ToString("dd/MM/yyyy"), Author = comment.User.FirstName + " " +comment.User.LastName });
        }

        //პოსტის რედაქტირება
        public ActionResult Edit(int id)
        {
            return View(db.Topics.FirstOrDefault(x => x.Id == id));
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Topic editedTopic, Image image, HttpPostedFileBase imageToUpload)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                var userid = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name);
                var topic = db.Topics.FirstOrDefault(x => x.Id == editedTopic.Id);
                topic.Title = editedTopic.Title;
                topic.Text = editedTopic.Text;
                if (imageToUpload != null)
                {
                    string fileExtension = Path.GetExtension(imageToUpload.FileName);
                    string newName = Generators.Random32();
                    string path = Server.MapPath("/Content/images/");
                    imageToUpload.SaveAs(path + newName + fileExtension);

                    image.Extension = fileExtension;
                    image.Name = newName;
                    image.Path = "/Content/images/";
                    db.Images.Add(image);
                    db.SaveChanges();

                    topic.ImageId = image.Id;
                }
                topic.LastEditDate = DateTime.Now;
                topic.UserId = userid.Id;
                db.SaveChanges();
                transaction.Complete();
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult MyTopics()
        {
            var userId = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name).Id;
            return View(db.Topics.OrderByDescending(x => x.CreationDate).Where(x => x.UserId == userId));
        }
    }
}