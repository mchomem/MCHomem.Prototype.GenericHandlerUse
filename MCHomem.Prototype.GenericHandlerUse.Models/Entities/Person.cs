using System;

namespace MCHomem.Prototype.GenericHandlerUse.Models.Entities
{
    [Serializable]
    public class Person
    {
        #region Properties

        public String Name { get; set; }
        public DateTime BirthDate { get; set; }

        #endregion

        #region Constructors

        public Person() { }

        public Person(String name, DateTime birthDate)
        {
            this.Name = name;
            this.BirthDate = birthDate;
        }

        #endregion
    }
}
