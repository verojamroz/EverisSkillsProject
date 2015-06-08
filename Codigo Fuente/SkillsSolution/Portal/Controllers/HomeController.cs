using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Models;
using System.Web.Security;
using System.Security.Principal;

namespace Portal.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            GenericPrincipal winPrincipal = (GenericPrincipal)HttpContext.User;

            if (winPrincipal.IsInRole("Admin"))
                return View();
            else
                return RedirectToAction("Index", "Employee");
        }

        
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        
        [HttpPost]
        public ActionResult Login(UserModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.IsValid())
                {
                    FormsAuthentication.SetAuthCookie(model.User.UserName, false);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", "Usuario o password incorrectos!");
                }
            }
            return View(model);
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Home");
        }



    }
}
