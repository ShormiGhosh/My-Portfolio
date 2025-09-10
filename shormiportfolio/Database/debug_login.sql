-- Database Verification and Troubleshooting Script
-- Run this to check if your database and admin user are set up correctly

USE master;
GO

-- Check if PortfolioDB database exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'PortfolioDB')
BEGIN
    PRINT '? PortfolioDB database exists'
    
    USE PortfolioDB;
    
    -- Check if AdminUsers table exists
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AdminUsers')
    BEGIN
        PRINT '? AdminUsers table exists'
        
        -- Check admin users
        SELECT 'Current Admin Users:' AS Info;
        SELECT 
            AdminID,
            Username,
            Password,
            Email,
            LEN(Username) AS UsernameLength,
            LEN(Password) AS PasswordLength,
            CASE 
                WHEN Username = 'admin' THEN '? Username matches'
                ELSE '? Username does not match expected'
            END AS UsernameStatus,
            CASE 
                WHEN Password = 'admin123' THEN '? Password matches'
                ELSE '? Password does not match expected'
            END AS PasswordStatus
        FROM AdminUsers;
        
        -- Check for whitespace issues
        SELECT 'Whitespace Check:' AS Info;
        SELECT 
            AdminID,
            CONCAT('[', Username, ']') AS UsernameWithBrackets,
            CONCAT('[', Password, ']') AS PasswordWithBrackets,
            CASE 
                WHEN Username != LTRIM(RTRIM(Username)) THEN '?? Username has whitespace'
                ELSE '? Username clean'
            END AS UsernameWhitespace,
            CASE 
                WHEN Password != LTRIM(RTRIM(Password)) THEN '?? Password has whitespace'
                ELSE '? Password clean'
            END AS PasswordWhitespace
        FROM AdminUsers;
        
    END
    ELSE
    BEGIN
        PRINT '? AdminUsers table does not exist'
        PRINT 'Solution: Run the createdatabase.sql script to create the table'
    END
END
ELSE
BEGIN
    PRINT '? PortfolioDB database does not exist'
    PRINT 'Solution: Run the createdatabase.sql script to create the database'
END

-- Test the exact query used by the application
USE PortfolioDB;
GO

PRINT ''
PRINT 'Testing login query with expected credentials...'

DECLARE @testUsername NVARCHAR(50) = 'admin'
DECLARE @testPassword NVARCHAR(255) = 'admin123'

SELECT 
    COUNT(*) AS MatchCount,
    CASE 
        WHEN COUNT(*) > 0 THEN '? Login should work'
        ELSE '? Login will fail'
    END AS LoginStatus
FROM AdminUsers 
WHERE LTRIM(RTRIM(Username)) = @testUsername 
AND LTRIM(RTRIM(Password)) = @testPassword;

-- If no matches, show what we do have
IF NOT EXISTS (SELECT * FROM AdminUsers WHERE LTRIM(RTRIM(Username)) = @testUsername AND LTRIM(RTRIM(Password)) = @testPassword)
BEGIN
    PRINT ''
    PRINT '? No matching admin user found. Here is what exists:'
    SELECT * FROM AdminUsers;
END

GO