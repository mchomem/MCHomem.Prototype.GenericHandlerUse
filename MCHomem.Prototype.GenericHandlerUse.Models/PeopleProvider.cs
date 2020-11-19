﻿using System;
using System.Collections.Generic;

namespace MCHomem.Prototype.GenericHandlerUse.Models
{
    public class PeopleProvider
    {
        public List<People> MokaData()
        {
            List<People> peoples = new List<People>();
            Random rYear = new Random();
            Random rMonth = new Random();
            Random rDay = new Random();
            Random rHour = new Random();
            Random rMinute = new Random();
            Random rSecond = new Random();

            Random n = new Random();
            Random sn = new Random();

            List<String> names = new List<String>();
            names.Add("Andre");
            names.Add("Bartolomeu");
            names.Add("Carlos");
            names.Add("Daniel");
            names.Add("Eduardo");

            List<String> secondNames = new List<String>();
            secondNames.Add("Andrey");
            secondNames.Add("Bart");
            secondNames.Add("Casa Grande");
            secondNames.Add("Dantes");
            secondNames.Add("Estevão");

            for (int i = 0; i < 5; i++)
            {
                People people = new People();
                people.Name = $"{names[n.Next(0, 4)]} {secondNames[sn.Next(0, 4)]}";
                people.BirthDate =
                    new DateTime
                    (
                        rYear.Next(1950, 2010)
                        , rMonth.Next(1, 12)
                        , rDay.Next(1, 28)
                        , rHour.Next(0, 23)
                        , rMinute.Next(0, 59)
                        , rSecond.Next(0, 59)
                    );

                peoples.Add(people);
            }

            return peoples;
        }
    }
}
