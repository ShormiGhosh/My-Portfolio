-- Verification script to check if database and tables are set up correctly
-- Run this after executing createdatabase.sql

USE PortfolioDB;
GO

-- Check if all tables exist
SELECT 'Tables Created Successfully' AS Status;

SELECT TABLE_NAME, TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Check sample data
SELECT 'Admin Users' AS DataType, COUNT(*) AS RecordCount FROM AdminUsers
UNION ALL
SELECT 'Profile Records', COUNT(*) FROM Profile
UNION ALL
SELECT 'Skill Categories', COUNT(*) FROM SkillCategories
UNION ALL
SELECT 'Skills', COUNT(*) FROM Skills
UNION ALL
SELECT 'Projects', COUNT(*) FROM Projects
UNION ALL
SELECT 'Achievements', COUNT(*) FROM Achievements
UNION ALL
SELECT 'Work Experience', COUNT(*) FROM WorkExperience;

-- Show admin user for login
SELECT 'Admin Login Credentials:' AS Info;
SELECT Username, Email FROM AdminUsers;