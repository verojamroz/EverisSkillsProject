using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;

namespace Portal.Models
{
    public class UserModel : ModelBase
    {
        public User User { get; set; }
        public bool IsValid()
        {
            return FromRepository.IsValidUser(this.User);
        }
    }
}