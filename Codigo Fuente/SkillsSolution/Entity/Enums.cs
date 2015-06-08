using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public static class Role
    {
        public static string Employee = "User";
        public static string Admin = "Admin";
        
    }
    
    public enum Status : int
    {
        Active = 1,
        Inactive = 0
    }
}
