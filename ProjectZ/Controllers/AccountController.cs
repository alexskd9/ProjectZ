using ProjectZ.Helpers;
using ProjectZ.Models;
using ProjectZ.Models.Account;
using ProjectZ.Models.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ProjectZ.Controllers
{
    public class AccountController : DbConnectionController
    {
        // ახალი მომხმარებლის რეგისტრაცია
        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(Registration user)
        {
            //მოწმდება, არის თუ არა ყველა ველი შევსებული
            if (ModelState.IsValid)
            {
                //ელ. ფოსტის უნიკალურობის შემოწმება
                var uniqueEmail = db.Users.Select(x => x.Email).ToList();
                //თუ ასეთი ფოსტა არ არის ბაზაში, ხდება ახალი მომხმარებლის რეგისტრაცია
                if (!uniqueEmail.Contains(user.Email))
                {
                    using (TransactionScope transaction = new TransactionScope())
                    {
                        db.UserToConfirms.Add(new Models.Database.UserToConfirm()
                        {
                            FirstName = user.Name,
                            LastName = user.Surname,
                            Email = user.Email,
                            Password = Generators.SHA512Hash(user.Password + Generators.Key),
                            City = user.City,
                            PostalCode = user.PostalCode,
                            Street = user.Street,
                            Appartment = user.Appartments,
                            IsAdministrator = false,
                            ConfirmationCode = Generators.Random32(),
                            CreationDate = DateTime.Now
                        });
                        TempData["data"] = user.Email;
                        db.SaveChanges();
                        transaction.Complete();
                    }
                }
                //თუ ასეთი ფოსტა არსებობს ბაზაში, გამოდის შესაბამისი შეცდომა
                else
                {
                    ViewBag.errorMsg = "ასეთი ელ. ფოსტა უკვე გამოიყენება";
                    return View();
                }
                return RedirectToAction("Verification", "Account");
            }
            else
            {
                return View();
            }
        }

        //რეგისტრაციის დასასრულებლად საჭიროა შესაბამის ბმულზე გადასვლა (თუ ბრაუზერი გაითიშა, ინფორმაცია არ შეინახება და მომხმარებელი რეგისტრაციას ვერ დაასრულებს)
        public ActionResult Verification()
        {
            var email = TempData["data"];
            ViewBag.ConfCode = db.UserToConfirms.FirstOrDefault(x => x.Email == email.ToString()).ConfirmationCode;
            return View();
        }

        //მომხმარებლის დადასტურება
        public ActionResult Confirmation(string id)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                var moveUser = db.UserToConfirms.FirstOrDefault(x => x.ConfirmationCode == id);
                db.Users.Add(new Models.Database.User()
                {
                    FirstName = moveUser.FirstName,
                    LastName = moveUser.LastName,
                    Email = moveUser.Email,
                    Password = moveUser.Password,
                    City = moveUser.City,
                    PostalCode = moveUser.PostalCode,
                    Street = moveUser.Street,
                    Appartment = moveUser.Appartment,
                    IsAdministrator = moveUser.IsAdministrator,
                    CreationDate = moveUser.CreationDate,
                    LastEditionDate = DateTime.Now
                });
                db.UserToConfirms.Remove(moveUser);
                db.SaveChanges();
                transaction.Complete();
            }
            return RedirectToAction("Login", "Account");
        }

        //სისტემაში შესვლა
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Login login)
        {
            //პაროლის ჰეშირება
            string password = Generators.SHA512Hash(login.Password + Generators.Key);
            //მომხმარებლის ძებნა ბაზაში
            var user = db.Users.FirstOrDefault(x => x.Email == login.Email);
            if (user != null)
            {
                //თუ პაროლი არასწორია, გამოდის შესაბამისი შეცდომა
                if (password != user.Password)
                {
                    if (login.Password != null)
                    {
                        ViewBag.errorPasswordMessage = "პაროლი მცდარია. სცადეთ კიდევ ერთელ";
                        return View();
                    }
                    ViewBag.errorPasswordMessage = "შეიყვანეთ პაროლი";
                    return View();
                }
                else
                {
                    //თუ ალამი ჩართულია, ინახება cookie და მომხმარებელი არ გადის სისტემიდან
                    if (login.RememberMe == true)
                    {
                        FormsAuthentication.SetAuthCookie(user.Email, true);
                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(user.Email, false);
                    }

                    Session["userName"] = user.FirstName;
                    Session["isAdmin"] = user.IsAdministrator;
                    //ბოლო შესვლის თარიღი
                    user.LastLoginDate = DateTime.Now;
                    db.SaveChanges();
                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                //თუ ელ. ფოსტა არასწორია, გამოდის შესაბამისი შეცდომა
                if (login.Email != null)
                {
                    ViewBag.errorLoginMessage = "ელ. ფოსტა არასწორია";
                    return View();
                }
                else
                {
                    return View();
                }
            }
        }

        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassword(ChangePassword changePassword)
        {
            var user = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name);
            string userOldPassword = user.Password;
            string oldPassword = Generators.SHA512Hash(changePassword.OldPassword + Generators.Key);
            if (ModelState.IsValid)
            {
                if (userOldPassword == oldPassword)
                {
                    string newPassword = Generators.SHA512Hash(changePassword.NewPassword + Generators.Key);
                    if (userOldPassword != newPassword)
                    {
                        user.Password = newPassword;
                        user.LastEditionDate = DateTime.Now;
                        db.SaveChanges();
                        return RedirectToAction("LogOut", "Account");
                    }
                    else
                    {
                        ViewBag.Msg = "ძველი და ახალი პაროლები არ უნდა ემთხვეოდეს ერთმანეთს";
                        return View();
                    }
                }
                else
                {
                    ViewBag.Msg = "ძველი პაროლი არასწორია";
                    return View();
                }
            }
            else
            {
                ViewBag.Msg = "სცადეთ კიდევ ერთხელ";
                return View();
            }
        }

        //მომხმარებლის მონაცემების ცვლილება
        public ActionResult EditPersonalData()
        {
            return View(db.Users.FirstOrDefault(x=>x.Email==User.Identity.Name));
        }

        //გადაწერა მოხდება მხოლოდ იმ შემთხვევაში, თუ ველი რედაქტირებულია და არაა ცარიელი,
        [HttpPost]
        public ActionResult EditPersonalData(User editedUser)
        {
            var userDataToEdit = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name);
            using (TransactionScope transaction = new TransactionScope())
            {
                if (editedUser.FirstName != null && editedUser.FirstName != userDataToEdit.FirstName)
                {
                    userDataToEdit.FirstName = editedUser.FirstName;
                }
                if (editedUser.LastName != null && editedUser.LastName != userDataToEdit.LastName)
                {
                    userDataToEdit.LastName = editedUser.LastName;
                }
                if (editedUser.City != null && editedUser.City != userDataToEdit.City)
                {
                    userDataToEdit.City = editedUser.City;
                }
                if (editedUser.PostalCode != null && editedUser.PostalCode != userDataToEdit.PostalCode)
                {
                    userDataToEdit.PostalCode = editedUser.PostalCode;
                }
                if (editedUser.Street != null && editedUser.Street != userDataToEdit.Street)
                {
                    userDataToEdit.Street = editedUser.Street;
                }
                if (editedUser.Appartment != null && editedUser.Appartment != userDataToEdit.Appartment)
                {
                    userDataToEdit.Appartment = editedUser.Appartment;
                }
                userDataToEdit.LastEditionDate = DateTime.Now;
                db.SaveChanges();
                transaction.Complete();
            }
            
            return RedirectToAction("ControlPanel","Account");
        }

        public ActionResult ControlPanel()
        {
            return View();
        }

        //სისტემიდან გასვლა და cookie-ის წაშლა
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
    }
}