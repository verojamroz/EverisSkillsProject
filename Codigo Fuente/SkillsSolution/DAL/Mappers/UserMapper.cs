using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAL.Mappers
{
    public class UserMapper
    {
        public User Map(Entity.User user)
        {
            User usr = new User();
            usr.CreationDate = DateTime.Now;
            usr.Password = user.Password;
            usr.Role = user.Role;
            //usr.Status = (int)user.Status;
            usr.UserName = user.UserName;

            return usr;
        
        }
    }
}
