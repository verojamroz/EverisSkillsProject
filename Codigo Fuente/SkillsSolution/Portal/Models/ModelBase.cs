using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;

namespace Portal.Models
{
    public class ModelBase
    {
        private SkillsRepository _repository;

        internal SkillsRepository FromRepository
        {
            get { return _repository; }
            set { _repository = value; }
        }

        public ModelBase()
        {
            _repository = new SkillsRepository();
        }
    }
}