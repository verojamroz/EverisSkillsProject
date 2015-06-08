using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;

namespace Portal.Models
{
    public class TechModel : ModelBase
    {
        public Technology Technology { get; set; }
        public IEnumerable<Technology> Technologies { get; set; }

        public void LoadTechnologies()
        {
            this.Technologies = FromRepository.GetTechnologies();
        }

        public void Delete(int id)
        {
            FromRepository.DeleteTechnology(id);
        }

        public void LoadForUpdate(int id)
        {
            this.Technology = FromRepository.GetTechnology(id);
        }

        public void Update()
        {
            FromRepository.UpdateTechnology(this.Technology);
        }

        public void Create()
        {
            FromRepository.CreateTechnology(this.Technology);
        }

    }
}