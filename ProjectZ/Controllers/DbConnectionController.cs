using System.Web.Mvc;
using ProjectZ.Models.Database;

namespace ProjectZ.Controllers
{
    //მონაცემთა ბაზასთან კავშირის არსებობის შემოწმება:
    //თუ კავშირი არ არის, მაშინ იქმნება ახალი,
    //ხოლო თუ არის, გამოიყენება არსებული კავშირი
    public class DbConnectionController : Controller
    {
        private ProjectZEntities _db { get; set; }
        protected ProjectZEntities db
        {
            get
            {
                if (_db == null)
                {
                    _db = new ProjectZEntities();
                }

                return _db;
            }
        }
    }
}