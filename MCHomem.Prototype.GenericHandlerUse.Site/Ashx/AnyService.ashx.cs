using MCHomem.Prototype.GenericHandlerUse.Models;
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
        public void ProcessRequest(HttpContext context)
        {
            String op = context.Request["op"];

            switch (op)
            {
                case "getPeoples":
                    GetPeoples(context);
                    break;
                default:
                    break;
            }
        }

        private void GetPeoples(HttpContext context)
        {
            try
            {
                JsonReturn jr = new JsonReturn();
                jr.Peoples = new PeopleProvider().MokaData();
                jr.Message = "Data retreave with success!";

                JavaScriptSerializer js = new JavaScriptSerializer();
                String data = js.Serialize(jr);

                context.Response.ContentType = "text/json";
                context.Response.ContentEncoding = Encoding.UTF8;
                context.Response.Write(data);
                context.Response.StatusCode = 200;
            }
            catch (Exception e)
            {
                // TODO create a log, send mail, etc
                context.Response.StatusCode = 500;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}