# Portfolio Admin Panel - ASP.NET WebForms

## Overview
This project connects your existing frontend portfolio with an ASP.NET WebForms backend and SQL Server database. It includes a complete admin panel for managing portfolio content.

## Features
- **Dynamic Portfolio Website**: Displays data from SQL Server database
- **Admin Authentication**: Secure login system for content management
- **Content Management**: Full CRUD operations for:
  - Profile information (photo and CV)
  - Skills by category
  - Projects with images and GitHub links
  - Achievements with descriptions and images
  - Work experience
- **Responsive Design**: Both frontend and admin panel work on mobile devices
- **Database Integration**: Uses your existing SQL database structure

## Technology Stack
- **.NET Framework 4.8**
- **ASP.NET WebForms**
- **SQL Server** (SQL Server Express LocalDB or full SQL Server)
- **HTML5, CSS3, JavaScript** (existing frontend)
- **Bootstrap-inspired admin styling**

## Setup Instructions

### Prerequisites
1. **Visual Studio 2019/2022** (Community, Professional, or Enterprise)
2. **SQL Server** (Express, LocalDB, or full version)
3. **IIS Express** (comes with Visual Studio)

### Database Setup

1. **Open SQL Server Management Studio (SSMS)**
2. **Connect to your SQL Server instance**: `DESKTOP-09335H0\SQLEXPRESS`
3. **Execute the database script**:
   - Open the file `Database/createdatabase.sql`
   - Execute the entire script to create the database and tables
   - This will create the `PortfolioDB` database with all necessary tables and sample data

### Application Configuration

1. **Update Connection String** (if needed):
   - Open `Web.config`
   - Modify the connection string if your SQL Server instance is different:
   ```xml
   <connectionStrings>
     <add name="PortfolioConnectionString" 
          connectionString="Data Source=YOUR_SERVER_NAME;Initial Catalog=PortfolioDB;Integrated Security=True" 
          providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

2. **Build the Solution**:
   - Open the project in Visual Studio
   - Build ? Build Solution (Ctrl+Shift+B)

### Running the Application

1. **Start the Application**:
   - Press F5 or click "Start" in Visual Studio
   - The application will launch in your default browser

2. **Access the Portfolio**:
   - Main website: `http://localhost:[port]/Default.aspx`
   - Admin login: `http://localhost:[port]/Admin/Login.aspx`

### Admin Panel Access

**Default Admin Credentials:**
- **Username**: `admin`
- **Password**: `admin123`

**Remember Me Feature:**
- ? Check "Keep me logged in for 7 days" to stay authenticated
- ?? Uses secure encrypted cookies for auto-login
- ?? Automatically logs you in for 7 days without re-entering credentials
- ??? Secure implementation with proper cookie encryption and validation

?? **Important**: Change these credentials in production!

## File Structure

```
shormiportfolio/
??? Database/
?   ??? createdatabase.sql          # Database creation script
??? FrontEnd/
?   ??? index.html                  # Original static HTML
?   ??? style.css                   # Frontend styling
?   ??? script.js                   # Frontend JavaScript
??? Admin/
?   ??? Login.aspx                  # Admin login page
?   ??? Login.aspx.cs               # Login logic
?   ??? Dashboard.aspx              # Admin dashboard
?   ??? Dashboard.aspx.cs           # Dashboard logic
?   ??? AdminStyles.css             # Admin panel styling
??? Default.aspx                    # Main portfolio page (dynamic)
??? Default.aspx.cs                 # Main page logic
??? Web.config                      # Application configuration
??? Global.asax                     # Application events
```

## Admin Panel Features

### Dashboard
- **Overview Statistics**: Count of skills, projects, achievements, and work experiences
- **Quick Navigation**: Easy access to all management sections

### Profile Management
- Update profile image path
- Update CV/Resume file path

### Skills Management
- Add/Edit/Delete skills
- Organize skills by categories:
  - Programming Languages
  - Frameworks & Libraries
  - Tools & Technologies
  - Soft Skills

### Projects Management
- Add/Edit/Delete projects
- Manage project details:
  - Title and description
  - Project image
  - GitHub repository link

### Achievements Management
- Add/Edit/Delete achievements
- Manage achievement details:
  - Title and description
  - Achievement image

### Work Experience Management
- Add/Edit/Delete work experiences
- Manage experience details:
  - Job title
  - Company name
  - Employment duration

## Database Schema

The application uses the following main tables:

- **AdminUsers**: Admin authentication
- **Profile**: Profile image and CV paths
- **SkillCategories**: Skill category definitions
- **Skills**: Individual skills linked to categories
- **Projects**: Project portfolio items
- **Achievements**: Achievement records
- **WorkExperience**: Professional experience records

## Security Features

- **Forms Authentication**: Secure login system with session management
- **Remember Me Functionality**: 7-day auto-login with encrypted cookies
- **Session Management**: Automatic logout after inactivity
- **Admin-Only Access**: Admin routes are protected from unauthorized access
- **SQL Injection Prevention**: Parameterized queries used throughout
- **Cookie Security**: HttpOnly and secure cookie settings
- **Encrypted Authentication**: Forms authentication tickets are encrypted
- **Session Validation**: User existence validation for auto-login scenarios

### Remember Me Implementation Details

The "Remember Me" feature uses the following security measures:

1. **Encrypted Cookies**: User credentials are encrypted using FormsAuthentication.Encrypt()
2. **Expiration Control**: Cookies automatically expire after 7 days
3. **Secure Transmission**: Cookies use HttpOnly flag to prevent XSS attacks
4. **User Validation**: System validates user existence before auto-login
5. **Clean Logout**: Proper cleanup of all cookies and sessions on logout
6. **Auto-refresh**: Remember Me cookies are refreshed on each successful auto-login

## Customization

### Adding New Admin Users
```sql
INSERT INTO AdminUsers (Username, Password, Email) 
VALUES ('newuser', 'newpassword', 'email@example.com');
```

### Modifying Skill Categories
Add new categories in the database:
```sql
INSERT INTO SkillCategories (CategoryName) VALUES ('New Category');
```

### Styling Customization
- **Frontend**: Modify `FrontEnd/style.css`
- **Admin Panel**: Modify `Admin/AdminStyles.css`

## Troubleshooting

### Common Issues

1. **Database Connection Error**:
   - Verify SQL Server is running
   - Check connection string in Web.config
   - Ensure PortfolioDB database exists

2. **Login Issues**:
   - Verify admin user exists in AdminUsers table
   - Check username/password case sensitivity

3. **Images Not Loading**:
   - Ensure image paths in database are correct
   - Verify images exist in the specified folders

4. **Build Errors**:
   - Restore NuGet packages
   - Check .NET Framework 4.8 is installed
   - Verify all references are resolved

### Logging and Debugging

- Enable debug mode in Web.config: `<compilation debug="true" />`
- Check Visual Studio Output window for detailed error messages
- Use SQL Server Profiler to monitor database queries

## Production Deployment

### Before Deploying:

1. **Update Connection String**: Use production database server
2. **Change Admin Credentials**: Update default admin password
3. **Disable Debug Mode**: Set `debug="false"` in Web.config
4. **Configure Security**: Set up proper authentication and authorization
5. **Backup Database**: Ensure you have database backups

### Deployment Options:
- **IIS**: Deploy to Internet Information Services
- **Azure**: Deploy to Azure App Service
- **Local Network**: Deploy to local web server

## Support and Maintenance

- **Database Backups**: Schedule regular backups of PortfolioDB
- **Security Updates**: Keep .NET Framework and SQL Server updated
- **Monitoring**: Monitor application performance and errors
- **Content Updates**: Use admin panel to keep portfolio content current

## License

This project is created for portfolio management purposes. Modify and use as needed for your portfolio website.

---

**Created**: 2025
**Framework**: .NET Framework 4.8
**Database**: SQL Server