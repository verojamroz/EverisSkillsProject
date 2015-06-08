using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;

namespace DAL
{
    public class SkillsRepository
    {
        private SkillsEntities _context = new SkillsEntities();

        public bool IsValidUser(Entity.User user)
        {
            var result = _context.Users.FirstOrDefault(u => u.UserName == user.UserName.ToLower() && u.Password == user.Password && u.Status == (int )Entity.Status.Active);
            return (result != null);
        }

        public bool IsAdminUser(string userName)
        {
            var result = _context.Users.FirstOrDefault(u => u.UserName.ToLower() == userName.ToLower());
            return (result.Role == Entity.Role.Admin);
        }

        #region Employee
        public IEnumerable<Entity.Employee> GetEmployees()
        {
            var emp = (

                from e in _context.Employees
                where e.Status == (int)Entity.Status.Active
                select new Entity.Employee()
                {
                    Id = e.Id,
                    FirstName = e.FirstName,
                    LastName = e.LastName,
                    IdUser = e.IdUser,
                    DNI = e.DNI,
                    Email = e.Email,
                    Phone = e.Phone,
                    User = new Entity.User()
                    {
                        Id = e.User.Id,
                        UserName = e.User.UserName,
                        CreationDate = e.CreationDate,
                        Role = e.User.Role
                    }

                }).ToList();

            return emp;
        }



        public void DeleteEmployee(int id)
        {
            Employee em = _context.Employees.FirstOrDefault(e => e.Id == id);
            em.Status = (int)Entity.Status.Inactive;
            _context.SaveChanges();
        }

        public void UpdateEmployee(Entity.Employee employee)
        {
            Employee em = _context.Employees.Include("User").FirstOrDefault(e => e.Id == employee.Id);

            var ep = _context.Employees.FirstOrDefault(e => e.Email.ToLower() == employee.Email.ToLower() && e.Id != employee.Id);
            if (ep != null)
            {
                throw new Exception("El email " + ep.Email + " ya esta siendo utilizado por otro empleado.");
            }

            ep = _context.Employees.FirstOrDefault(e => e.DNI == employee.DNI && e.Id != employee.Id);
            if (ep != null)
            {
                throw new Exception("Ya existe empleado con el DNI ingresado");
            }

            em.FirstName = employee.FirstName;
            em.LastName = employee.LastName;
            em.DNI = employee.DNI;
            em.Email = employee.Email;
            em.Phone = employee.Phone;
            

            _context.SaveChanges();
        }

        public Entity.Employee GetEmployee(int id)
        {
            var emp = (

                from e in _context.Employees.Include("User")
                where e.Id == id
                select new Entity.Employee()
                {
                    Id = e.Id,
                    FirstName = e.FirstName,
                    LastName = e.LastName,
                    IdUser = e.IdUser,
                    DNI = e.DNI,
                    Email = e.Email,
                    Phone = e.Phone,
                    User = new Entity.User() { 
                        Id = e.User.Id,
                        UserName = e.User.UserName,
                        CreationDate = e.CreationDate,
                        Role = e.User.Role
                    }

                }).SingleOrDefault();

            return emp;
        }

        public Entity.Employee GetEmployee(string userName)
        {
            var emp = (

                from e in _context.Employees.Include("User")
                where e.User.UserName.ToLower() == userName.ToLower()
                select new Entity.Employee()
                {
                    Id = e.Id,
                    FirstName = e.FirstName,
                    LastName = e.LastName,
                    IdUser = e.IdUser,
                    DNI = e.DNI,
                    Email = e.Email,
                    Phone = e.Phone,
                    User = new Entity.User()
                    {
                        Id = e.User.Id,
                        UserName = e.User.UserName,
                        CreationDate = e.CreationDate,
                        Role = e.User.Role
                    }

                }).SingleOrDefault();

            return emp;
        }

        public void CreateEmployee(Entity.Employee employee)
        {
            //Check if exist
            var ep = _context.Employees.FirstOrDefault(e => e.DNI == employee.DNI);
            if (ep != null)
            {
                throw new Exception("Ya existe empleado con el DNI ingresado");
            }

            ep = _context.Employees.FirstOrDefault(e => e.Email.ToLower() == employee.Email.ToLower());
            if (ep != null)
            {
                throw new Exception("El email " + ep.Email + " ya esta siendo utilizado por otro empleado.");
            }

            var usr = _context.Users.FirstOrDefault(e => e.UserName.ToLower() == employee.User.UserName.ToLower());
            if (usr != null)
            {
                throw new Exception("El nombre de usuario " + usr.UserName + " ya esta siendo utilizado por otro empleado.");
            }

            User user = new User();
            user.UserName = employee.User.UserName;
            user.Password = employee.User.Password;
            user.Role = employee.User.Role;
            user.CreationDate = DateTime.Now;
            user.Status = (int)Entity.Status.Active;
            
            Employee emp = new Employee();
            emp.Id = employee.Id;
            emp.FirstName = employee.FirstName;
            emp.LastName = employee.LastName;
            emp.IdUser = employee.IdUser;
            emp.DNI = employee.DNI;
            emp.Email = employee.Email;
            emp.Phone = employee.Phone;
            emp.Status = (int) Entity.Status.Active;
            emp.CreationDate = DateTime.Now;

            user.Employees.Add(emp);

            _context.Users.Add(user);

            _context.SaveChanges();
            
        }
        #endregion

        #region Tech
        public IEnumerable<Entity.Technology> GetTechnologies()
        {
            var tec = (

                from e in _context.Technologies
                where e.Status == (int)Entity.Status.Active
                select new Entity.Technology()
                {
                    Id = e.Id,
                    Description = e.Description,
                    Name = e.Name
                }).ToList();

            return tec;
        }

        

        public void DeleteTechnology(int id)
        {
            Technology tec = _context.Technologies.FirstOrDefault(e => e.Id == id);
            tec.Status = (int)Entity.Status.Inactive;
            _context.SaveChanges();
        }

        public void UpdateTechnology(Entity.Technology tech)
        {
            Technology tec = _context.Technologies.FirstOrDefault(e => e.Id == tech.Id);

            tec.Description = tech.Description;
            tec.Name = tech.Name;

            _context.SaveChanges();
        }

        public void CreateTechnology(Entity.Technology tech)
        {
            //Check if exist
            var ep = _context.Technologies.FirstOrDefault(e => e.Name.ToLower() == tech.Name.ToLower());
            if (ep != null)
            {
                throw new Exception("Ya existe una tecnología con ese nombre");
            }

            Technology te = new Technology();
            te.Description = tech.Description;
            te.Name = tech.Name;
            te.Status = (int)Entity.Status.Active;

            _context.Technologies.Add(te);
            
            _context.SaveChanges();
        }

        public Entity.Technology GetTechnology(int id)
        {
            var tec = (

                from e in _context.Technologies
                where e.Id == id
                select new Entity.Technology()
                {
                    Id = e.Id,
                    Description = e.Description,
                    Name = e.Name

                }).SingleOrDefault();

            return tec;

        }
        #endregion

        #region Skills

        public List<Entity.Technology> GetTechnologiesSkills(int idEmployee)
        {
            var tec = (

                from e in _context.Technologies
                where e.Status == (int)Entity.Status.Active
                select new Entity.Technology()
                {
                    Id = e.Id,
                    Description = e.Description,
                    Name = e.Name,
                    SkillId = 1

                }).ToList();


            foreach (var es in GetEmployeeSkills(idEmployee))
            {
                tec.Find(t => t.Id == es.IdTechnology).SkillId = es.IdSkill;
            }

            return tec;
        }

        public void SaveTechnologySkills(int idEmployee, List<Entity.Technology> techs)
        {
            DeleteSkills(idEmployee);
            foreach (var t in techs)
            {
                _context.EmployeeSkills.Add(new EmployeeSkill()
                {
                    IdEmployee = idEmployee,
                    IdSkill = t.SkillId,
                    IdTechnology = t.Id
                });
            }

            _context.SaveChanges();

        }
        
        public List<Entity.Skill> GetSkills()
        {
            var sk = (

                from e in _context.Skills
                orderby e.Id
                select new Entity.Skill()
                {
                    Id = e.Id,
                    Description = e.Description
                }).ToList();

            return sk;
        }

        private List<Entity.EmployeeSkills> GetEmployeeSkills(int idEmployee)
        {
            var sk = (

                from e in _context.EmployeeSkills
                where e.IdEmployee == idEmployee
                select new Entity.EmployeeSkills()
                {
                    IdSkill= e.IdSkill,
                    IdTechnology = e.IdTechnology
                }).ToList();

            return sk;
        }

        private void DeleteSkills(int employeeId)
        {
            _context.EmployeeSkills.RemoveRange(_context.EmployeeSkills.Where(e => e.IdEmployee == employeeId));
            _context.SaveChanges();
        }

        #endregion


    }
}
