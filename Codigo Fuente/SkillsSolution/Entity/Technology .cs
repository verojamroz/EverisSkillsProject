using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace Entity
{
    public class Technology
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Descripción es requerido")]
        [Display(Name = "Descripción")]
        public string Description { get; set; }
        [Required(ErrorMessage = "Nombre es requerido")]
        [Display(Name = "Nombre")]
        public string Name { get; set; }

        public int SkillId { get; set; }

        
    }
}
