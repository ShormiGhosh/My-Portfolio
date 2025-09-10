<%@ WebHandler Language="C#" Class="PortfolioData" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

public class PortfolioData : IHttpHandler
{
    private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

    public void ProcessRequest(HttpContext context)
    {
        // Enable CORS
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        context.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        context.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        
        if (context.Request.HttpMethod == "OPTIONS")
        {
            context.Response.StatusCode = 200;
            return;
        }

        context.Response.ContentType = "application/json";

        string type = context.Request.QueryString["type"];
        
        try
        {
            string jsonResponse = string.Empty;
            JavaScriptSerializer js = new JavaScriptSerializer();
            
            switch (type?.ToLower())
            {
                case "skills":
                    jsonResponse = GetSkills(js);
                    break;
                case "projects":
                    jsonResponse = GetProjects(js);
                    break;
                case "achievements":
                    jsonResponse = GetAchievements(js);
                    break;
                case "workexperience":
                    jsonResponse = GetWorkExperience(js);
                    break;
                case "profile":
                    jsonResponse = GetProfile(js);
                    break;
                case "all":
                    jsonResponse = GetAllData(js);
                    break;
                default:
                    jsonResponse = js.Serialize(new { error = "Invalid type parameter" });
                    break;
            }

            context.Response.Write(jsonResponse);
        }
        catch (Exception ex)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(new { error = ex.Message }));
        }
    }

    private string GetSkills(JavaScriptSerializer js)
    {
        var skillsByCategory = new Dictionary<string, List<object>>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = @"
                SELECT s.SkillName, sc.CategoryName 
                FROM Skills s 
                INNER JOIN SkillCategories sc ON s.CategoryID = sc.CategoryID 
                ORDER BY sc.CategoryName, s.SkillName";
            
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string category = reader["CategoryName"].ToString();
                        string skill = reader["SkillName"].ToString();
                        
                        if (!skillsByCategory.ContainsKey(category))
                        {
                            skillsByCategory[category] = new List<object>();
                        }
                        
                        skillsByCategory[category].Add(new { name = skill });
                    }
                }
            }
        }

        return js.Serialize(skillsByCategory);
    }

    private string GetProjects(JavaScriptSerializer js)
    {
        var projects = new List<object>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = "SELECT ProjectID, Title, Description, ImagePath, GitHubURL FROM Projects ORDER BY ProjectID";
            
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projects.Add(new
                        {
                            id = Convert.ToInt32(reader["ProjectID"]),
                            title = reader["Title"].ToString(),
                            description = reader["Description"].ToString(),
                            imagePath = reader["ImagePath"].ToString(),
                            githubUrl = reader["GitHubURL"].ToString()
                        });
                    }
                }
            }
        }

        return js.Serialize(projects);
    }

    private string GetAchievements(JavaScriptSerializer js)
    {
        var achievements = new List<object>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = "SELECT AchievementID, Title, Description, ImagePath FROM Achievements ORDER BY AchievementID";
            
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        achievements.Add(new
                        {
                            id = Convert.ToInt32(reader["AchievementID"]),
                            title = reader["Title"].ToString(),
                            description = reader["Description"].ToString(),
                            imagePath = reader["ImagePath"].ToString()
                        });
                    }
                }
            }
        }

        return js.Serialize(achievements);
    }

    private string GetWorkExperience(JavaScriptSerializer js)
    {
        var workExperiences = new List<object>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = "SELECT ExperienceID, JobTitle, CompanyName, Duration FROM WorkExperience ORDER BY ExperienceID";
            
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        workExperiences.Add(new
                        {
                            id = Convert.ToInt32(reader["ExperienceID"]),
                            jobTitle = reader["JobTitle"].ToString(),
                            companyName = reader["CompanyName"].ToString(),
                            duration = reader["Duration"].ToString()
                        });
                    }
                }
            }
        }

        return js.Serialize(workExperiences);
    }

    private string GetProfile(JavaScriptSerializer js)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = "SELECT TOP 1 ProfileImagePath, CVPath FROM Profile";
            
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var profile = new
                        {
                            profileImagePath = reader["ProfileImagePath"].ToString(),
                            cvPath = reader["CVPath"].ToString()
                        };
                        
                        return js.Serialize(profile);
                    }
                }
            }
        }
        
        return js.Serialize(new { profileImagePath = "", cvPath = "" });
    }

    private string GetAllData(JavaScriptSerializer js)
    {
        var allData = new
        {
            skills = js.DeserializeObject(GetSkills(js)),
            projects = js.DeserializeObject(GetProjects(js)),
            achievements = js.DeserializeObject(GetAchievements(js)),
            workExperience = js.DeserializeObject(GetWorkExperience(js)),
            profile = js.DeserializeObject(GetProfile(js))
        };

        return js.Serialize(allData);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}