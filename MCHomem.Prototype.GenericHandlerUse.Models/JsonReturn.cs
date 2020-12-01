using System;
using System.Collections.Generic;

namespace MCHomem.Prototype.GenericHandlerUse.Models
{
    [Serializable()]
    public class JsonReturn<E>
    {
        #region Properties

        public E Entity { get; set; }
        public List<E> Entities { get; set; }
        public String Message { get; set; }

        #endregion
    }
}
