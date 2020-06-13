using System;
using System.Collections.Generic;

namespace MCHomem.Prototype.GenericHandlerUse.Models
{
    [Serializable()]
    public class JsonReturn
    {
        public List<People> Peoples { get; set; }
        public String Message { get; set; }
    }
}
