using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;

namespace Portal.Models
{
    public class EmployeeModel : ModelBase
    {
        public Employee Employee { get; set; }
        public List<Technology> Tecnologies { get; set; }
        public List<Skill> Skills { get; set; }

        public EmployeeModel()
        {
            Employee = new Employee();
            this.Employee.User = new User();
            this.Employee.User.Role = Entity.Role.Employee;
            this.Employee.User.CreationDate = DateTime.Now;
            this.Employee.User.Status = Status.Active;

            Tecnologies = new List<Technology>();
            Skills = new List<Skill>();
        }

        
        public void LoadEmployee(string userName)
        {
            this.Employee = FromRepository.GetEmployee(userName);
            this.Tecnologies = FromRepository.GetTechnologiesSkills(this.Employee.Id);
            this.Skills = FromRepository.GetSkills();
        }

        public void SaveSkills()
        {
            FromRepository.SaveTechnologySkills(this.Employee.Id, this.Tecnologies);
        }
    }
}