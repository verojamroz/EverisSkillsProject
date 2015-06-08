using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace Entity
{
    public class User
    {
        public int Id { get; set; }
        
        [Required(ErrorMessage = "Nombre de usuario es requerido.")]
        [Display(Name = "Nombre de usuario")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password es requerido.")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Repetir Password")]
        public string RetypePassword { get; set; }
        
        [Display(Name = "Rol")]
        public string Role { get; set; }
        
        public DateTime CreationDate { get; set; }
        public Status Status { get; set; }
    }
}
