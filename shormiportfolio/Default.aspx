<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="shormiportfolio.Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Shormi Ghosh's personal portfolio showcasing her education,skills, projects, and contact information." />
    <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet" />
    <!-- Font Awesome Icons - Very reliable -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="icon" type="image/x-icon" href="FrontEnd/img/favicon.ico" />
    <link rel="stylesheet" href="FrontEnd/style.css" />
    <title>Portfolio - Shormi Ghosh</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- loading -->
        <div class="loader">
            <div class="txt">Loading...</div>
            <div class="loadbar">
                <div class="spinner"></div>
            </div>
        </div>
        <!-- main page -->
        <a id="top"></a>
        <header>
            <nav>
                <div class="nav-container">
                    <div class="left">Shormi Ghosh</div>
                    <ul class="nav-list">
                        <li><a href="#home">Home</a></li>
                        <li><a href="#about">About</a></li>
                        <li><a href="#skills">Skills</a></li>
                        <li><a href="#projects">Projects</a></li>
                        <li><a href="#achievements">Achievements</a></li>
                        <li><a href="#contact-section">Contact</a></li>
                    </ul>
                    <div style="display: flex; align-items: center">
                        <div class="theme-toggle" id="themeToggle">
                            <span class="material-symbols-outlined theme-togg-icon light">light_mode</span>
                            <span class="material-symbols-outlined theme-togg-icon dark">dark_mode</span>
                        </div>
                    </div>
                    <div class="menu-toggle" id="menuToggle">
                        <span class="material-symbols-outlined">menu</span>
                    </div>
                </div>
            </nav>
            <div class="mobile-menu" id="mobileMenu">
                <a href="#home">Home</a>
                <a href="#about">About</a>
                <a href="#skills">Skills</a>
                <a href="#projects">Projects</a>
                <a href="#achievements">Achievements</a>
                <a href="#contact-section">Contact</a>
            </div>
        </header>
        <main>
            <!-- home section -->
            <section class="profile" id="home">
                <div class="profile-bg"></div>
                <div class="profile-content">
                    <h2 class="greeting">Hello I'm</h2>
                    <h1 class="name">Shormi Ghosh</h1>
                    <h1 class="description">A <span class="typing-demo"></span></h1>
                    <span class="buttons">
                        <a href="#contact-section" class="btn contact-me-btn">Contact Me</a>
                        <asp:HyperLink ID="lnkDownloadCV" runat="server" CssClass="btn down-cv-btn">Download CV</asp:HyperLink>
                    </span>
                    <ul class="social-icons">
                        <li><a href="https://www.linkedin.com/in/shormi-ghosh-225112255/" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                        <li><a href="https://github.com/ShormiGhosh" target="_blank"><i class="fab fa-github"></i></a></li>
                        <li><a href="https://www.facebook.com/shormi.ghosh.923" target="_blank"><i class="fab fa-facebook"></i></a></li>
                        <li><a href="https://www.instagram.com/shormi.__" target="_blank"><i class="fab fa-instagram"></i></a></li>
                    </ul>
                </div>
                <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" AlternateText="Profile Picture" />
                <spline-viewer class="spline-viewer" url="https://prod.spline.design/GSj1lTcc4TTth3-v/scene.splinecode"></spline-viewer>
            </section>
            
            <!-- about section -->
            <section id="about">
                <div class="about-container">
                    <div class="row">
                        <div class="about-col1">
                            <img src="FrontEnd/photos/profile-about.jpg" alt="profile image">
                        </div>
                        <div class="about-col2">
                            <h1 class="subtitle">About Me</h1>
                            <p class="para">I am a Computer Science and Engineering undergraduate with a strong interest in problem solving and exploring innovative approaches to technology. Beyond academics, I have a passion for photography, which allows me to combine creativity with technical precision. I enjoy tackling challenges, learning new skills, and working on projects that create meaningful impact. My goal is to grow as a versatile professional by blending analytical thinking with creativity in both technology and art.</p>
                            <div class="tab-titles">
                                <p class="tablink active-link" onclick="toggleTab('education')">Education</p>
                                <p class="tablink" onclick="toggleTab('work')">Work Experiences</p>
                            </div>
                            <div class="tab-contents">
                                <div class="tabcontent active-content" id="education">
                                    <ul>
                                        <li><span>B.Sc. in Computer Science and Engineering </span><br>Khulna University of Engineering & Technology | 2023 - Present</li>
                                        <li><span>Higher Secondary Certificate (HSC)</span><br>Govt. M.M. City College, Khulna | 2019 - 2021</li>
                                        <li><span>Secondary School Certificate (SSC)</span><br>Khulna Collegiate Girls' School, Khulna | 2017 - 2019</li>
                                    </ul>
                                </div>
                                <div class="tabcontent" id="work">
                                    <div class="work-experience-container">
                                        <div class="experience-list" id="experienceList">
                                            <asp:Repeater ID="rptWorkExperience" runat="server">
                                                <ItemTemplate>
                                                    <div class="experience-item">
                                                        <div class="company"><%# Eval("CompanyName") %></div>
                                                        <div class="position"><%# Eval("JobTitle") %></div>
                                                        <div class="duration"><%# Eval("Duration") %></div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <div class="no-experience" id="noExperience" runat="server">
                                            <p>No work experience yet</p>
                                            <span>Currently focusing on education and building skills</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- skill section -->
            <section id="skills">
                <h1>Skills & Expertise</h1>
                <div class="soft-technical">
                    <asp:Repeater ID="rptSkillCategories" runat="server">
                        <ItemTemplate>
                            <div class='<%# GetCategoryClass(Eval("CategoryName").ToString()) %>'>
                                <h2>
                                    <span class="material-symbols-outlined skill-icon"><%# GetCategoryIcon(Eval("CategoryName").ToString()) %></span>
                                    <%# Eval("CategoryName") %>
                                </h2>
                                <ul>
                                    <asp:Repeater ID="rptSkills" runat="server" DataSource='<%# GetSkillsByCategory((int)Eval("CategoryID")) %>'>
                                        <ItemTemplate>
                                            <li><%# Eval("SkillName") %></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
            
            <!-- Project section -->
            <section id="projects">
                <div class="projects-container">
                    <h1>My Projects</h1>
                    <div class="project-list">
                        <asp:Repeater ID="rptProjects" runat="server">
                            <ItemTemplate>
                                <div class="project-item">
                                    <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Title") %>'>
                                    <div class="layer">
                                        <h3><%# Eval("Title") %></h3>
                                        <p><%# Eval("Description") %></p>
                                        <a href='<%# Eval("GitHubURL") %>' target="_blank"><i class="fab fa-github"></i></a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </section>
            
            <!-- Achievements Section -->
            <section id="achievements">
                <h1>Achievements</h1>
                <div class="achievements-container">
                    <asp:Repeater ID="rptAchievements" runat="server">
                        <ItemTemplate>
                            <div class="achievement-item">
                                <div class="achievement-image">
                                    <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Title") %>'>
                                </div>
                                <div class="achievement-content">
                                    <h3 class="achievement-title"><%# Eval("Title") %></h3>
                                    <p class="achievement-description"><%# Eval("Description") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
            
            <!-- contact me page -->
            <section id="contact-section">
                <h1>Get In Touch</h1>
                <div class="contact-bg">
                    <div class="contact-info">
                        <p>If you have any questions or inquiries, feel free to reach out!</p>
                        <ul>
                            <li><span class="material-symbols-outlined">mail</span>shormighosh111@gmail.com</li>
                            <li><span class="material-symbols-outlined">call</span>+880 1919320102</li>
                            <li><span class="material-symbols-outlined">distance</span>Khulna, Bangladesh</li>
                        </ul>
                        <ul class="social-icons">
                            <li><a href="https://www.linkedin.com/in/shormi-ghosh-225112255/" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                            <li><a href="https://github.com/ShormiGhosh" target="_blank"><i class="fab fa-github"></i></a></li>
                            <li><a href="https://www.facebook.com/shormi.ghosh.923" target="_blank"><i class="fab fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/shormi.__" target="_blank"><i class="fab fa-instagram"></i></a></li>
                        </ul>
                    </div>
                    <div class="contact-form">
                        <div class="form-row">
                            <span>
                                <label for="txtName">Name:</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                            </span>
                            <span>
                                <label for="txtEmail">Email:</label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" required="true"></asp:TextBox>
                            </span>
                        </div>
                        <span>
                            <label for="txtSubject">Subject:</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </span>
                        <label for="txtMessage">Message:</label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" required="true"></asp:TextBox>
                        <asp:Button ID="btnSendMessage" runat="server" Text="Send Message" CssClass="btn-submit" OnClick="btnSendMessage_Click" />
                        <div id="form-status" runat="server" style="margin-top: 1rem; text-align: center;"></div>
                    </div>
                </div>
            </section>
        </main>
        <footer>
            &copy; <span id="year"></span> Shormi Ghosh | All rights reserved
        </footer>
        <a href="#top" class="back-to-top" title="Back to Top" style="margin-left: 20px">
            <span class="material-symbols-outlined">expand_circle_up</span>
        </a>
    </form>
    
    <script src="FrontEnd/script.js"></script>
    <script type="module" src="https://unpkg.com/@splinetool/viewer@1.10.51/build/spline-viewer.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/ScrollTrigger.min.js"></script>
</body>
</html>