using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Configuration;

namespace Entity
{
    public class Employee
    {
        public int Id { get; set; }
        public int IdUser { get; set; }
        [Required(ErrorMessage = "Nombre es requerido")]
        [Display(Name = "Nombre")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Apellido es requerido")]
        [Display(Name = "Apellido")]
        public string LastName { get; set; }
        [Required(ErrorMessage = "Teléfono es requerido")]
        [Display(Name = "Teléfono")]
        public string Phone { get; set; }
        [Required(ErrorMessage = "Email es requerido")]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email")]
        [RegularExpression("^[a-zA-Z0-9_\\.-]+@([a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$", ErrorMessage = "Formato de email inválido")]
        public string Email { get; set; }
        [Required(ErrorMessage = "DNI es requerido")]
        [Display(Name = "DNI")]
        [IntegerValidator(MinValue = 1, MaxValue = 99999999, ExcludeRange = false)]
        public int DNI { get; set; }

        public User User { get; set; }

        public Employee()
        {
            User = new User();
        }
    }
}
