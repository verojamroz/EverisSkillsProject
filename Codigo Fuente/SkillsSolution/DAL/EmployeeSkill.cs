//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class EmployeeSkill
    {
        public int IdEmployee { get; set; }
        public int IdTechnology { get; set; }
        public int IdSkill { get; set; }
    
        public virtual Employee Employee { get; set; }
        public virtual Skill Skill { get; set; }
        public virtual Technology Technology { get; set; }
    }
}