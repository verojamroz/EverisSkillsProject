using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;

namespace Portal.Models
{
    public class AdminModel : ModelBase
    {
        public IEnumerable<Employee> Employees { get; set; }
        public Employee Employee { get; set; }

        public AdminModel()
        {
            Employee = new Employee();
            this.Employee.User = new User();
            this.Employee.User.Role = Entity.Role.Employee;
            this.Employee.User.CreationDate = DateTime.Now;
            this.Employee.User.Status = Status.Active;
        }

        public void LoadEmployees()
        {
            this.Employees = FromRepository.GetEmployees();
        }

        public void DeleteEmployee(int idEmployee)
        {
            FromRepository.DeleteEmployee(idEmployee);
        }

        public void LoadEmployeeForUpdate(int id)
        {
            this.Employee =  FromRepository.GetEmployee(id);
        }

        public void UpdateEmployee()
        {
            FromRepository.UpdateEmployee(this.Employee);
        }

        public void CreateEmployee()
        {
            FromRepository.CreateEmployee(this.Employee);
        }
    }
}
