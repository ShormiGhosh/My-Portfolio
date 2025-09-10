<%@ WebHandler Language="C#" Class="RefreshNotifier" %>

using System;
using System.Web;
using System.Web.SessionState;

public class RefreshNotifier : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        // Enable CORS
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        context.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        context.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        
        if (context.Request.HttpMethod == "OPTIONS")
        {
            context.Response.StatusCode = 200;
            return;
        }

        context.Response.ContentType = "application/json";
        
        string action = context.Request.QueryString["action"];
        
        try
        {
            switch (action?.ToLower())
            {
                case "notify":
                    // Set a refresh flag (can be expanded to use SignalR for real-time updates)
                    Application["LastDataUpdate"] = DateTime.Now;
                    context.Response.Write("{\"success\": true, \"message\": \"Frontend notified to refresh\"}");
                    break;
                case "check":
                    DateTime lastUpdate = Application["LastDataUpdate"] as DateTime? ?? DateTime.MinValue;
                    context.Response.Write($"{{\"lastUpdate\": \"{lastUpdate:yyyy-MM-dd HH:mm:ss}\", \"timestamp\": {lastUpdate.Ticks}}}");
                    break;
                default:
                    context.Response.Write("{\"error\": \"Invalid action parameter\"}");
                    break;
            }
        }
        catch (Exception ex)
        {
            context.Response.Write($"{{\"error\": \"{ex.Message}\"}}");
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}