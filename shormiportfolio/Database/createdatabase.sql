-- Portfolio Database Creation Script
-- Server: DESKTOP-09335H0\SQLEXPRESS

USE master;
GO

-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PortfolioDB')
BEGIN
    CREATE DATABASE PortfolioDB;
END
GO

USE PortfolioDB;
GO

-- Create Admin Users Table
CREATE TABLE AdminUsers (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL
);

-- Create Profile Table (Home Section - Profile Image and CV PDF)
CREATE TABLE Profile (
    ProfileID INT IDENTITY(1,1) PRIMARY KEY,
    ProfileImagePath NVARCHAR(255),
    CVPath NVARCHAR(255)
);

-- Create Skill Categories Table
CREATE TABLE SkillCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

-- Create Skills Table
CREATE TABLE Skills (
    SkillID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    SkillName NVARCHAR(100) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES SkillCategories(CategoryID)
);

-- Create Projects Table (Project Image, Title, Description, GitHub Link)
CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    ImagePath NVARCHAR(255),
    GitHubURL NVARCHAR(255)
);

-- Create Achievements Table (Title, Description, Image)
CREATE TABLE Achievements (
    AchievementID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(300) NOT NULL,
    Description NVARCHAR(MAX),
    ImagePath NVARCHAR(255)
);

-- Create Work Experience Table (Job Title, Company Name, Duration)
CREATE TABLE WorkExperience (
    ExperienceID INT IDENTITY(1,1) PRIMARY KEY,
    JobTitle NVARCHAR(200) NOT NULL,
    CompanyName NVARCHAR(200) NOT NULL,
    Duration NVARCHAR(100)
);

-- Insert default admin user (password: admin123)
INSERT INTO AdminUsers (Username, Password, Email) 
VALUES ('admin', 'admin123', 'shormighosh111@gmail.com');

-- Insert Profile Data
INSERT INTO Profile (ProfileImagePath, CVPath)
VALUES ('photos/profile.jpg', 'assets/Shormi Ghosh CV.pdf');

-- Insert Skill Categories
INSERT INTO SkillCategories (CategoryName) VALUES
('Programming Languages'),
('Frameworks & Libraries'),
('Tools & Technologies'),
('Soft Skills');

-- Insert Skills
DECLARE @progLangID INT = (SELECT CategoryID FROM SkillCategories WHERE CategoryName = 'Programming Languages');
DECLARE @frameworkID INT = (SELECT CategoryID FROM SkillCategories WHERE CategoryName = 'Frameworks & Libraries');
DECLARE @toolsID INT = (SELECT CategoryID FROM SkillCategories WHERE CategoryName = 'Tools & Technologies');
DECLARE @softSkillsID INT = (SELECT CategoryID FROM SkillCategories WHERE CategoryName = 'Soft Skills');

INSERT INTO Skills (CategoryID, SkillName) VALUES
(@progLangID, 'C'),
(@progLangID, 'C++'),
(@progLangID, 'C#'),
(@progLangID, 'Java'),
(@progLangID, 'Python'),
(@progLangID, 'Dart'),
(@progLangID, 'TypeScript'),
(@progLangID, 'JavaScript'),
(@progLangID, 'SQL'),

(@frameworkID, 'Flutter'),
(@frameworkID, 'JavaFX'),
(@frameworkID, 'Flame'),
(@frameworkID, 'Tailwind CSS'),

(@toolsID, 'Git & GitHub'),
(@toolsID, 'SQLite'),
(@toolsID, 'MySQL'),
(@toolsID, 'HTML'),
(@toolsID, 'CSS'),
(@toolsID, 'VS Code'),
(@toolsID, 'Android Studio'),
(@toolsID, 'Figma'),
(@toolsID, 'Canva'),

(@softSkillsID, 'Communication'),
(@softSkillsID, 'Teamwork'),
(@softSkillsID, 'Problem-solving'),
(@softSkillsID, 'Adaptability'),
(@softSkillsID, 'Time Management');

-- Insert Projects
INSERT INTO Projects (Title, Description, ImagePath, GitHubURL) VALUES
('ParaBounce', 'A squid game theme based Projectile Motion with Air Resistance Simulator', 
 'photos/parabounce.JPG', 'https://github.com/ShormiGhosh/ParaBounce--Projectile-Motion-Simulation'),
('PixAid', 'A desktop application for selling photographs for donation purposes.', 
 'photos/pixaid.JPG', 'https://github.com/ShormiGhosh/PixAid__DesktopApplication'),
('Python AI Assistant', 'A virtual assistant built with Python', 
 'photos/protibimb.JPG', 'https://github.com/ShormiGhosh/python_project_protibimba-My-AI-assistant-');

-- Insert Achievements
INSERT INTO Achievements (Title, Description, ImagePath) VALUES
('1st Runner-up in the Bridging Engineering & Computer Science Competition 2025',
 'Our team Kuet-Kobe-Khulbe completed our project for the "Bridging Engineering & Computer Science" international hackathon, co-hosted by ILM AI and City St George''s, University of London. We worked on: ParaBounce —A squid game theme based Projectile Motion with Air Resistance Simulator - Simulating real-world projectile motion by modelling drag forces and solving dynamic equations in real time.',
 'photos/achievment1.jpeg'),
('Best All-Girls Team in Intra KUET Programming Contest 2023',
 'This was my first onsite programming contest and our team secured the title of Best All-Girls Team. It was a great experience that boosted my confidence and skills in competitive programming.',
 'photos/acievement2.jpeg');

GO