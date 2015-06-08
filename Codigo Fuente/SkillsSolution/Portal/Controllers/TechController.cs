using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Models;

namespace Portal.Controllers
{
    [Authorize(Roles = "Admin")]
    public class TechController : Controller
    {
        public ActionResult List()
        {
            TechModel em = new TechModel();
            em.LoadTechnologies();
            return View(em);
        }

        [HttpGet]
        public ActionResult Update(int? id)
        {
            TechModel model = new TechModel();
            if (ModelState.IsValid)
            {
                if (id.HasValue)
                {
                    model.LoadForUpdate(id.Value);
                }
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult Update(TechModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    model.Update();
                    return RedirectToAction("List", "Tech");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Delete(int? id)
        {
            TechModel model = new TechModel();
            model.Delete(id.Value);
            return RedirectToAction("List", "Tech");
        }

        public ActionResult New()
        {
            TechModel em = new TechModel();
            return View(em);
        }

        [HttpPost]
        public ActionResult New(TechModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    model.Create();
                    return RedirectToAction("List", "Tech");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }

            }
            return View(model);
        }

    }
}
