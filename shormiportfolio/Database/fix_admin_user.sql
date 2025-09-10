-- Quick Fix Script: Ensure Admin User Exists
-- This script will create or update the admin user with correct credentials

USE PortfolioDB;
GO

-- Check if admin user exists and fix if needed
IF EXISTS (SELECT * FROM AdminUsers WHERE Username = 'admin')
BEGIN
    -- Update existing admin user
    UPDATE AdminUsers 
    SET Password = 'admin123', 
        Email = 'shormighosh111@gmail.com'
    WHERE Username = 'admin';
    
    PRINT '? Updated existing admin user'
END
ELSE
BEGIN
    -- Insert new admin user
    INSERT INTO AdminUsers (Username, Password, Email) 
    VALUES ('admin', 'admin123', 'shormighosh111@gmail.com');
    
    PRINT '? Created new admin user'
END

-- Verify the admin user
SELECT 'Admin User Verification:' AS Info;
SELECT 
    AdminID,
    Username,
    Password,
    Email,
    CASE 
        WHEN Username = 'admin' AND Password = 'admin123' THEN '? Credentials correct'
        ELSE '? Credentials incorrect'
    END AS Status
FROM AdminUsers 
WHERE Username = 'admin';

PRINT ''
PRINT '?? Login Credentials:'
PRINT 'Username: admin'
PRINT 'Password: admin123'
PRINT ''
PRINT 'You can now try logging in with these credentials.'

GO