using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Models;

namespace Portal.Controllers
{
    public class EmployeeController : Controller
    {

        public ActionResult Index()
        {
            EmployeeModel em = new EmployeeModel();
            em.LoadEmployee(User.Identity.Name);
            ViewBag.ShowNotification = false;
            return View(em);
        }

        [HttpPost]
        public ActionResult Index(EmployeeModel model)
        {
            model.SaveSkills();
            model.LoadEmployee(User.Identity.Name);
            ViewBag.ShowNotification = true;
            return View(model);
        }
        
        
        #region Solo para admin
        [Authorize(Roles = "Admin")]
        public ActionResult List()
        {
            AdminModel em = new AdminModel();
            em.LoadEmployees();
            
            return View(em);
        }
        
        [Authorize(Roles = "Admin")]
        public ActionResult New()
        {
            AdminModel em = new AdminModel();
            return View(em);
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public ActionResult New(AdminModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (model.Employee.User.Password == model.Employee.User.RetypePassword)
                    {
                        model.CreateEmployee();
                        return RedirectToAction("List", "Employee");
                    }
                    ModelState.AddModelError("", "Password y Repetir Password deben ser iguales");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
                
            }
            return View(model);
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public ActionResult Update(int? id)
        {
            AdminModel model = new AdminModel();
            if (ModelState.IsValid)
            {
                if (id.HasValue)
                {
                    model.LoadEmployeeForUpdate(id.Value);
                }
            }
            return View(model);
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public ActionResult Update(AdminModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    model.UpdateEmployee();
                    return RedirectToAction("List", "Employee");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(model);
            
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            AdminModel model = new AdminModel();
            model.DeleteEmployee(id.Value);
            return RedirectToAction("List", "Employee");
        }

        #endregion
    }
}
