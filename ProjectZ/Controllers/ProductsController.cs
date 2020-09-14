using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using ProjectZ.Helpers;
using ProjectZ.Models;
using ProjectZ.Models.Database;

namespace ProjectZ.Controllers
{
    [Authorize]
    public class ProductsController : DbConnectionController
    {
        [AllowAnonymous]
        public ActionResult AllProducts()
        {

            if (HttpContext.User.Identity.IsAuthenticated)
            {
                var userid = GetUserId();
                var carts = db.UserCarts.Where(x => x.UserId == userid);
                foreach (var c in carts)
                {
                    if (c.Result == null && db.UserCartProducts.Select(x => x.UserCartId).Contains(c.Id))
                    {
                        decimal cartSum = db.UserCartProducts.Where(x => x.UserCartId == c.Id).Sum(x => x.Product.Price * x.Qty);
                        ViewBag.Sum = Math.Round(cartSum, 2);
                        break;
                    }
                    else
                    {
                        ViewBag.Sum = 0;
                    }
                }
            }
            return View(db.Products);
        }

        public ActionResult AddProduct()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddProduct(Product product, HttpPostedFileBase imageToUpload, Image image)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
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

                    product.ImageId = image.Id;
                }
                db.Products.Add(product);
                db.SaveChanges();
                transaction.Complete();
            }
            return RedirectToAction("AllProducts", "Products");
        }

        public ActionResult Details(int id)
        {
            var productInfo = db.Products.FirstOrDefault(x => x.Id == id);
            int userId = GetUserId();
            return View(new ProductExtended()
            {
                Product = productInfo,
                IsFavourite = db.FavouriteProducts.FirstOrDefault(x => x.ProductId == id && x.UserId == userId) != null ? true : false
            });
            //return View(productInfo);
        }

        [AllowAnonymous]
        public JsonResult Search(string searchItem)
        {
            if (!String.IsNullOrEmpty(searchItem))
            {
                return Json(db.Products.Where(x => x.Name.ToLower().Contains(searchItem.ToLower())).Select(x => new SearchProduct()
                {
                    Id = x.Id,
                    Name = x.Name
                }));
            }
            else
            {
                return Json("");
            }
        }
        public JsonResult AddToCart(int productId)
        {
            var userid = GetUserId();
            var userCart = db.UserCarts.FirstOrDefault(x => x.UserId == userid && x.Result == null);
            if (userCart != null)
            {
                var product = db.UserCartProducts.FirstOrDefault(x => x.ProductId == productId);
                if (product != null && product.ProductId.Equals(productId))
                {
                    product.Qty += 1;
                }
                else
                {
                    db.UserCartProducts.Add(new UserCartProduct()
                    {
                        ProductId = productId,
                        Qty = 1,
                        UserCartId = userCart.Id,
                        CreationDate = DateTime.Now
                    });
                }
            }
            else
            {
                var newCart = db.UserCarts.Add(new UserCart()
                {
                    UserId = userid,
                    CreationDate = DateTime.Now
                });
                db.SaveChanges();

                db.UserCartProducts.Add(new UserCartProduct()
                {
                    ProductId = productId,
                    Qty = 1,
                    UserCartId = newCart.Id,
                    CreationDate = DateTime.Now
                });
            }
            db.SaveChanges();

            int cartID = db.UserCarts.FirstOrDefault(x => x.UserId == userid && x.Result == null).Id;
            decimal cartSum = db.UserCartProducts.Where(x => x.UserCartId == cartID).Sum(x => x.Product.Price * x.Qty);
            ViewBag.Sum = Math.Round(cartSum, 2);
            return Json(cartSum);
        }

        public ActionResult Favourites()
        {
            int userId = GetUserId();
            return View(db.FavouriteProducts.Where(x => x.UserId == userId));
        }

        public JsonResult AddToFavourite(int productid)
        {
            var userid = GetUserId();
            db.FavouriteProducts.Add(new FavouriteProduct()
            {
                UserId = userid,
                ProductId = productid
            });
            db.SaveChanges();

            return Json(true);
        }

        public JsonResult RemoveFromFavourite(int productid)
        {
            var userId = GetUserId();
            var toRemove = db.FavouriteProducts.FirstOrDefault(x => x.ProductId == productid && x.UserId == userId);
            db.FavouriteProducts.Remove(toRemove);
            db.SaveChanges();
            return Json(true);
        }

        public ActionResult Cart()
        {
            int userId = db.Users.FirstOrDefault(x => x.Email == HttpContext.User.Identity.Name).Id;
            var userCart = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
            ViewBag.CartAmount = GetCartTotalAmount(userId);
            if (userCart != null)
            {
                var cart = userCart.UserCartProducts.Select(x => new Cart()
                {
                    CartProductId = x.Id,
                    ProductId = x.ProductId,
                    ProductImage = x.Product.Image.Path + x.Product.Image.Name + x.Product.Image.Extension,
                    ProductName = x.Product.Name,
                    Price = x.Product.Price,
                    Qty = x.Qty
                });
                return View(cart);
            }
            return View();
        }

        public ActionResult Purchase()
        {
            decimal sum = 0;
            int userId = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name).Id;
            var userCart = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
            if (userCart != null)
            {
                var cart = userCart.UserCartProducts.Select(x => new Cart()
                {
                    ProductId = x.ProductId,
                    Price = x.Product.Price,
                    Qty = x.Qty
                });
                foreach (var item in cart)
                {
                    sum += item.Qty * db.Products.FirstOrDefault(x => x.Id == item.ProductId).Price;
                }
            }

            PurchaseClass pc = new PurchaseClass()
            {
                UserID = userId,
                FirstName = db.Users.FirstOrDefault(x => x.Id == userId).FirstName,
                LastName = db.Users.FirstOrDefault(x => x.Id == userId).LastName,
                City = db.Users.FirstOrDefault(x => x.Id == userId).City,
                PostalCode = db.Users.FirstOrDefault(x => x.Id == userId).PostalCode,
                Street = db.Users.FirstOrDefault(x => x.Id == userId).Street,
                Appartments = db.Users.FirstOrDefault(x => x.Id == userId).Appartment,
                TotalAmount = sum

            };
            return View(pc);
        }

        [HttpPost]
        public ActionResult Purchase(Sale sale)
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                int userId = db.Users.FirstOrDefault(x => x.Email == User.Identity.Name).Id;
                var userCart = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
                var lastDocNum = db.Sales.Select(x => x.SDocNumber).ToList();

                if (lastDocNum.Count == 0)
                {
                    sale.SDocNumber = 1;
                }
                else
                {
                    sale.SDocNumber = lastDocNum.Last() + 1;
                }

                if (userCart != null)
                {
                    var cart = userCart.UserCartProducts.Select(x => new Cart()
                    {
                        ProductId = x.ProductId,
                        Price = x.Product.Price,
                        Qty = x.Qty
                    });
                    foreach (var item in cart)
                    {
                        sale.CustomerId = userId;
                        sale.MtId = item.ProductId;
                        sale.MtQty = item.Qty;
                        sale.MtPrice = item.Price;
                        sale.City = db.Users.FirstOrDefault(x => x.Id == userId).City;
                        sale.PostalCode = db.Users.FirstOrDefault(x => x.Id == userId).PostalCode;
                        sale.Street = db.Users.FirstOrDefault(x => x.Id == userId).Street;
                        sale.Appartment = db.Users.FirstOrDefault(x => x.Id == userId).Appartment;
                        sale.SDate = DateTime.Now;

                        db.Sales.Add(sale);
                        db.SaveChanges();
                    }
                }
                var userCartId = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null).Id;
                var userCartProduct = db.UserCartProducts.Where(x => x.UserCartId == userCartId).Select(x => x.Id);

                foreach (var item in userCartProduct)
                {
                    db.UserCartProducts.Remove(db.UserCartProducts.Find(item));
                }
                db.SaveChanges();

                var cartIsCompleted = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
                cartIsCompleted.Result = true;
                db.SaveChanges();
                transaction.Complete();
            }
            return RedirectToAction("Success", "Products");
        }

        public ActionResult Success()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ClearCart()
        {
            using (TransactionScope transaction = new TransactionScope())
            {
                var userId = GetUserId();
                var userCart = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
                var userCartProduct = db.UserCartProducts.Where(x => x.UserCartId == userCart.Id).Select(x => x.Id);

                if (userCart != null)
                {
                    foreach (var item in userCartProduct)
                    {
                        db.UserCartProducts.Remove(db.UserCartProducts.Find(item));
                    }
                    db.SaveChanges();

                    db.UserCarts.Remove(db.UserCarts.Find(userCart.Id));
                    db.SaveChanges();
                    transaction.Complete();
                }
            }
            return RedirectToAction("AllProducts", "Products");
        }

        [HttpPost]
        public JsonResult ChangeProductQty(int cartProductId, int opType)
        {
            var userId = GetUserId();
            var cartProduct = db.UserCartProducts.FirstOrDefault(x => x.Id == cartProductId);
            switch (opType)
            {
                case 0:
                    if (cartProduct.Qty > 1)
                    {
                        cartProduct.Qty -= 1;
                    }
                    break;
                case 1: cartProduct.Qty += 1; break;
            }
            db.SaveChanges();

            return Json(new ProductQty()
            {
                Quantity = cartProduct.Qty,
                Sum = cartProduct.Qty * cartProduct.Product.Price,
                cartAmount = GetCartTotalAmount(userId)
            });
        }

        [HttpPost]
        public JsonResult RemoveFromCart(int cartProductId)
        {
            var userId = GetUserId();
            var cartProduct = db.UserCartProducts.FirstOrDefault(x => x.Id == cartProductId);
            db.UserCartProducts.Remove(cartProduct);
            db.SaveChanges();
            return Json(new
            {
                cartAmount = GetCartTotalAmount(userId)
            });
        }

        public decimal GetCartTotalAmount(int userId)
        {
            decimal totalAmount = 0;
            var cartId = db.UserCarts.FirstOrDefault(x => x.UserId == userId && x.Result == null);
            if (cartId != null)
            {
                var cart = db.UserCartProducts.Where(x => x.UserCartId == cartId.Id);
                foreach (var item in cart)
                {
                    totalAmount += item.Qty * item.Product.Price;
                }
            }
            return totalAmount;
        }

        public int GetUserId()
        {
            return db.Users.FirstOrDefault(x => x.Email == User.Identity.Name).Id;
        }
    }
}