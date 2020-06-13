using System;
using System.Collections.Generic;

namespace MCHomem.Prototype.GenericHandlerUse.Models
{
    public class PeopleProvider
    {
        public List<People> MokaData()
        {
            List<People> peoples = new List<People>();
            Random ry = new Random();
            Random rm = new Random();
            Random rd = new Random();
            Random n = new Random();
            Random sn = new Random();

            String[] names = new String[] { "Andre", "Bartolomeu", "Carlos", "Daniel", "Eduardo" };
            String[] sobreNomes = new String[] { "Andrey", "Bart", "Casa Grande", "Dantes", "Estevão" };

            for (int i = 0; i < 5; i++)
            {
                People people = new People();
                people.Name = String.Format("{0} {1}", names[n.Next(0, 4)], sobreNomes[sn.Next(0, 4)]);
                people.BirthDate = new DateTime(ry.Next(1950, 2010), rm.Next(1, 12), rd.Next(1, 28));
                peoples.Add(people);
            }

            return peoples;
        }
    }
}
