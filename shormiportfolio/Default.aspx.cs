using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace shormiportfolio
{
    public partial class Default : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfileData();
                LoadSkillCategories();
                LoadProjects();
                LoadAchievements();
                LoadWorkExperience();
            }
        }

        private void LoadProfileData()
        {
            try
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
                                imgProfile.ImageUrl = reader["ProfileImagePath"].ToString();
                                lnkDownloadCV.NavigateUrl = reader["CVPath"].ToString();
                                lnkDownloadCV.Attributes["download"] = "Shormi_Ghosh_CV.pdf";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error or handle appropriately
                imgProfile.ImageUrl = "FrontEnd/photos/profile.jpg";
                lnkDownloadCV.NavigateUrl = "FrontEnd/assets/Shormi Ghosh CV.pdf";
            }
        }

        private void LoadSkillCategories()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT CategoryID, CategoryName FROM SkillCategories ORDER BY CategoryID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            rptSkillCategories.DataSource = dt;
                            rptSkillCategories.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle error
            }
        }

        protected DataTable GetSkillsByCategory(int categoryId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT SkillName FROM Skills WHERE CategoryID = @CategoryID ORDER BY SkillName";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        protected string GetCategoryClass(string categoryName)
        {
            switch (categoryName.ToLower())
            {
                case "programming languages":
                    return "programing-lang";
                case "frameworks & libraries":
                    return "frame-lib";
                case "tools & technologies":
                    return "tool-technology";
                case "soft skills":
                    return "soft";
                default:
                    return "programing-lang";
            }
        }

        protected string GetCategoryIcon(string categoryName)
        {
            switch (categoryName.ToLower())
            {
                case "programming languages":
                    return "data_object";
                case "frameworks & libraries":
                    return "flutter";
                case "tools & technologies":
                    return "terminal";
                case "soft skills":
                    return "psychology";
                default:
                    return "data_object";
            }
        }

        private void LoadProjects()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Title, Description, ImagePath, GitHubURL FROM Projects ORDER BY ProjectID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            rptProjects.DataSource = dt;
                            rptProjects.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle error
            }
        }

        private void LoadAchievements()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Title, Description, ImagePath FROM Achievements ORDER BY AchievementID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            rptAchievements.DataSource = dt;
                            rptAchievements.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle error
            }
        }

        private void LoadWorkExperience()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT JobTitle, CompanyName, Duration FROM WorkExperience ORDER BY ExperienceID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            if (dt.Rows.Count > 0)
                            {
                                rptWorkExperience.DataSource = dt;
                                rptWorkExperience.DataBind();
                                noExperience.Visible = false;
                            }
                            else
                            {
                                noExperience.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                noExperience.Visible = true;
            }
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            try
            {
                // Simple contact form handling - you can implement email sending here
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                // For now, just show success message
                // In production, you would send an email or save to database
                
                form_status.InnerHtml = "<p style='color: var(--accent); font-weight: bold;'>Message sent successfully! I'll get back to you soon.</p>";
                
                // Clear form
                txtName.Text = "";
                txtEmail.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                form_status.InnerHtml = "<p style='color: #ff6b6b; font-weight: bold;'>Sorry, there was an error sending your message. Please try again.</p>";
            }
        }
    }
}