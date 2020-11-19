using System;
using System.Collections.Generic;

namespace MCHomem.Prototype.GenericHandlerUse.Models
{
    [Serializable()]
    public class JsonReturn<E>
    {
        public List<E> Entities { get; set; }
        public String Message { get; set; }
    }
}
