<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="shormiportfolio.Admin.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Portfolio</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="AdminStyles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <!-- Header -->
            <header class="admin-header">
                <div class="header-content">
                    <h1>Portfolio Admin Dashboard</h1>
                    <div class="header-actions">
                        <span class="welcome-text">Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label></span>
                        <a href="../Default.aspx" class="btn btn-view-site" target="_blank">
                            <i class="fas fa-external-link-alt"></i> View Site
                        </a>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-logout" OnClick="btnLogout_Click">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </asp:LinkButton>
                    </div>
                </div>
            </header>

            <!-- Navigation -->
            <nav class="admin-nav">
                <div class="nav-content">
                    <asp:LinkButton ID="btnDashboard" runat="server" CssClass="nav-item active" CommandArgument="dashboard" OnCommand="NavigateSection">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnProfile" runat="server" CssClass="nav-item" CommandArgument="profile" OnCommand="NavigateSection">
                        <i class="fas fa-user"></i> Profile
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSkills" runat="server" CssClass="nav-item" CommandArgument="skills" OnCommand="NavigateSection">
                        <i class="fas fa-code"></i> Skills
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnProjects" runat="server" CssClass="nav-item" CommandArgument="projects" OnCommand="NavigateSection">
                        <i class="fas fa-folder-open"></i> Projects
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAchievements" runat="server" CssClass="nav-item" CommandArgument="achievements" OnCommand="NavigateSection">
                        <i class="fas fa-trophy"></i> Achievements
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnWorkExperience" runat="server" CssClass="nav-item" CommandArgument="work" OnCommand="NavigateSection">
                        <i class="fas fa-briefcase"></i> Work Experience
                    </asp:LinkButton>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="admin-main">
                <!-- Auto-login notification -->
                <asp:Panel ID="pnlAutoLogin" runat="server" Visible="false" CssClass="auto-login-notice">
                    <div class="auto-login-content">
                        <i class="fas fa-info-circle"></i>
                        <span>You were automatically logged in using your saved credentials.</span>
                        <asp:LinkButton ID="btnDismissNotice" runat="server" CssClass="dismiss-notice" OnClick="btnDismissNotice_Click">×</asp:LinkButton>
                    </div>
                </asp:Panel>

                <!-- Dashboard Overview -->
                <asp:Panel ID="pnlDashboard" runat="server">
                    <div class="section-header">
                        <h2><i class="fas fa-tachometer-alt"></i> Dashboard Overview</h2>
                    </div>
                    <div class="dashboard-stats">
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-code"></i></div>
                            <div class="stat-info">
                                <h3><asp:Label ID="lblSkillsCount" runat="server">0</asp:Label></h3>
                                <p>Skills</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-folder-open"></i></div>
                            <div class="stat-info">
                                <h3><asp:Label ID="lblProjectsCount" runat="server">0</asp:Label></h3>
                                <p>Projects</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                            <div class="stat-info">
                                <h3><asp:Label ID="lblAchievementsCount" runat="server">0</asp:Label></h3>
                                <p>Achievements</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-briefcase"></i></div>
                            <div class="stat-info">
                                <h3><asp:Label ID="lblWorkExpCount" runat="server">0</asp:Label></h3>
                                <p>Work Experiences</p>
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <!-- Profile Section -->
                <asp:Panel ID="pnlProfile" runat="server" Visible="false">
                    <div class="section-header">
                        <h2><i class="fas fa-user"></i> Profile Management</h2>
                    </div>
                    <div class="form-container">
                        <div class="form-group">
                            <label>Profile Image Path:</label>
                            <asp:TextBox ID="txtProfileImagePath" runat="server" CssClass="form-control" placeholder="e.g., photos/profile.jpg"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>CV/Resume Path:</label>
                            <asp:TextBox ID="txtCVPath" runat="server" CssClass="form-control" placeholder="e.g., assets/CV.pdf"></asp:TextBox>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdateProfile_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <!-- Skills Section -->
                <asp:Panel ID="pnlSkills" runat="server" Visible="false">
                    <div class="section-header">
                        <h2><i class="fas fa-code"></i> Skills Management</h2>
                        <asp:Button ID="btnAddSkill" runat="server" Text="Add New Skill" CssClass="btn btn-success" OnClick="btnAddSkill_Click" />
                    </div>
                    
                    <!-- Add/Edit Skill Form -->
                    <asp:Panel ID="pnlSkillForm" runat="server" CssClass="form-container" Visible="false">
                        <h3><asp:Label ID="lblSkillFormTitle" runat="server">Add New Skill</asp:Label></h3>
                        <asp:HiddenField ID="hfSkillID" runat="server" />
                        <div class="form-group">
                            <label>Category:</label>
                            <asp:DropDownList ID="ddlSkillCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label>Skill Name:</label>
                            <asp:TextBox ID="txtSkillName" runat="server" CssClass="form-control" placeholder="Enter skill name"></asp:TextBox>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnSaveSkill" runat="server" Text="Save Skill" CssClass="btn btn-primary" OnClick="btnSaveSkill_Click" />
                            <asp:Button ID="btnCancelSkill" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelSkill_Click" />
                        </div>
                    </asp:Panel>

                    <!-- Skills List -->
                    <div class="table-container">
                        <asp:GridView ID="gvSkills" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                            OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillID">
                            <Columns>
                                <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                                <asp:BoundField DataField="SkillName" HeaderText="Skill Name" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditSkill" runat="server" CommandName="EditSkill" 
                                            CommandArgument='<%# Eval("SkillID") %>' CssClass="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteSkill" runat="server" CommandName="DeleteSkill" 
                                            CommandArgument='<%# Eval("SkillID") %>' CssClass="btn btn-sm btn-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this skill?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>

                <!-- Projects Section -->
                <asp:Panel ID="pnlProjects" runat="server" Visible="false">
                    <div class="section-header">
                        <h2><i class="fas fa-folder-open"></i> Projects Management</h2>
                        <asp:Button ID="btnAddProject" runat="server" Text="Add New Project" CssClass="btn btn-success" OnClick="btnAddProject_Click" />
                    </div>
                    
                    <!-- Add/Edit Project Form -->
                    <asp:Panel ID="pnlProjectForm" runat="server" CssClass="form-container" Visible="false">
                        <h3><asp:Label ID="lblProjectFormTitle" runat="server">Add New Project</asp:Label></h3>
                        <asp:HiddenField ID="hfProjectID" runat="server" />
                        <div class="form-group">
                            <label>Title:</label>
                            <asp:TextBox ID="txtProjectTitle" runat="server" CssClass="form-control" placeholder="Enter project title"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Description:</label>
                            <asp:TextBox ID="txtProjectDescription" runat="server" TextMode="MultiLine" Rows="4" 
                                CssClass="form-control" placeholder="Enter project description"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Image Path:</label>
                            <asp:TextBox ID="txtProjectImagePath" runat="server" CssClass="form-control" placeholder="e.g., photos/project.jpg"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>GitHub URL:</label>
                            <asp:TextBox ID="txtProjectGitHubURL" runat="server" CssClass="form-control" placeholder="https://github.com/..."></asp:TextBox>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnSaveProject" runat="server" Text="Save Project" CssClass="btn btn-primary" OnClick="btnSaveProject_Click" />
                            <asp:Button ID="btnCancelProject" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelProject_Click" />
                        </div>
                    </asp:Panel>

                    <!-- Projects List -->
                    <div class="table-container">
                        <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                            OnRowCommand="gvProjects_RowCommand" DataKeyNames="ProjectID">
                            <Columns>
                                <asp:BoundField DataField="Title" HeaderText="Title" />
                                <asp:BoundField DataField="Description" HeaderText="Description" />
                                <asp:BoundField DataField="ImagePath" HeaderText="Image Path" />
                                <asp:BoundField DataField="GitHubURL" HeaderText="GitHub URL" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditProject" runat="server" CommandName="EditProject" 
                                            CommandArgument='<%# Eval("ProjectID") %>' CssClass="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteProject" runat="server" CommandName="DeleteProject" 
                                            CommandArgument='<%# Eval("ProjectID") %>' CssClass="btn btn-sm btn-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this project?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>

                <!-- Achievements Section -->
                <asp:Panel ID="pnlAchievements" runat="server" Visible="false">
                    <div class="section-header">
                        <h2><i class="fas fa-trophy"></i> Achievements Management</h2>
                        <asp:Button ID="btnAddAchievement" runat="server" Text="Add New Achievement" CssClass="btn btn-success" OnClick="btnAddAchievement_Click" />
                    </div>
                    
                    <!-- Add/Edit Achievement Form -->
                    <asp:Panel ID="pnlAchievementForm" runat="server" CssClass="form-container" Visible="false">
                        <h3><asp:Label ID="lblAchievementFormTitle" runat="server">Add New Achievement</asp:Label></h3>
                        <asp:HiddenField ID="hfAchievementID" runat="server" />
                        <div class="form-group">
                            <label>Title:</label>
                            <asp:TextBox ID="txtAchievementTitle" runat="server" CssClass="form-control" placeholder="Enter achievement title"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Description:</label>
                            <asp:TextBox ID="txtAchievementDescription" runat="server" TextMode="MultiLine" Rows="4" 
                                CssClass="form-control" placeholder="Enter achievement description"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Image Path:</label>
                            <asp:TextBox ID="txtAchievementImagePath" runat="server" CssClass="form-control" placeholder="e.g., photos/achievement.jpg"></asp:TextBox>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnSaveAchievement" runat="server" Text="Save Achievement" CssClass="btn btn-primary" OnClick="btnSaveAchievement_Click" />
                            <asp:Button ID="btnCancelAchievement" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelAchievement_Click" />
                        </div>
                    </asp:Panel>

                    <!-- Achievements List -->
                    <div class="table-container">
                        <asp:GridView ID="gvAchievements" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                            OnRowCommand="gvAchievements_RowCommand" DataKeyNames="AchievementID">
                            <Columns>
                                <asp:BoundField DataField="Title" HeaderText="Title" />
                                <asp:BoundField DataField="Description" HeaderText="Description" />
                                <asp:BoundField DataField="ImagePath" HeaderText="Image Path" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditAchievement" runat="server" CommandName="EditAchievement" 
                                            CommandArgument='<%# Eval("AchievementID") %>' CssClass="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteAchievement" runat="server" CommandName="DeleteAchievement" 
                                            CommandArgument='<%# Eval("AchievementID") %>' CssClass="btn btn-sm btn-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this achievement?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>

                <!-- Work Experience Section -->
                <asp:Panel ID="pnlWorkExperience" runat="server" Visible="false">
                    <div class="section-header">
                        <h2><i class="fas fa-briefcase"></i> Work Experience Management</h2>
                        <asp:Button ID="btnAddWorkExp" runat="server" Text="Add New Experience" CssClass="btn btn-success" OnClick="btnAddWorkExp_Click" />
                    </div>
                    
                    <!-- Add/Edit Work Experience Form -->
                    <asp:Panel ID="pnlWorkExpForm" runat="server" CssClass="form-container" Visible="false">
                        <h3><asp:Label ID="lblWorkExpFormTitle" runat="server">Add New Work Experience</asp:Label></h3>
                        <asp:HiddenField ID="hfWorkExpID" runat="server" />
                        <div class="form-group">
                            <label>Job Title:</label>
                            <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Enter job title"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Company Name:</label>
                            <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Enter company name"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Duration:</label>
                            <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="e.g., Jan 2023 - Present"></asp:TextBox>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnSaveWorkExp" runat="server" Text="Save Experience" CssClass="btn btn-primary" OnClick="btnSaveWorkExp_Click" />
                            <asp:Button ID="btnCancelWorkExp" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelWorkExp_Click" />
                        </div>
                    </asp:Panel>

                    <!-- Work Experience List -->
                    <div class="table-container">
                        <asp:GridView ID="gvWorkExperience" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                            OnRowCommand="gvWorkExperience_RowCommand" DataKeyNames="ExperienceID">
                            <Columns>
                                <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                <asp:BoundField DataField="Duration" HeaderText="Duration" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditWorkExp" runat="server" CommandName="EditWorkExp" 
                                            CommandArgument='<%# Eval("ExperienceID") %>' CssClass="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteWorkExp" runat="server" CommandName="DeleteWorkExp" 
                                            CommandArgument='<%# Eval("ExperienceID") %>' CssClass="btn btn-sm btn-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this work experience?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>

                <!-- Success/Error Messages -->
                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <div id="messageContainer" runat="server" class="alert">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
                </asp:Panel>
            </main>
        </div>
    </form>
</body>
</html>