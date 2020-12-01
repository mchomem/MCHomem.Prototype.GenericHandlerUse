using MCHomem.Prototype.GenericHandlerUse.Models;
using MCHomem.Prototype.GenericHandlerUse.Models.Entities;
using MCHomem.Prototype.GenericHandlerUse.Models.Repositories;
using System;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace MCHomem.Prototype.GenericHandlerUse.Site.Ashx
{
    /// <summary>
    /// Summary description for AnyService
    /// </summary>
    public class AnyService : IHttpHandler
    {
        #region Methods from IHttpHandler interface

        public void ProcessRequest(HttpContext context)
        {
            String op = context.Request["op"];

            switch (op)
            {
                case "getPeople":
                    GetPeople(context);
                    break;
                default:
                    break;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #endregion

        #region Methods

        private void GetPeople(HttpContext context)
        {
            try
            {
                JsonReturn<Person> jr = new JsonReturn<Person>();
                jr.Entities = new PersonRepository().MokaData();
                jr.Message = "Data retreave with success!";

                JavaScriptSerializer js = new JavaScriptSerializer();
                String data = js.Serialize(jr);

                context.Response.ContentType = "text/json";
                context.Response.ContentEncoding = Encoding.UTF8;
                context.Response.Write(data);
                context.Response.StatusCode = 200;
            }
            catch (Exception)
            {
                // TODO create a log, send mail, etc
                context.Response.StatusCode = 500;
            }
        }

        #endregion
    }
}
