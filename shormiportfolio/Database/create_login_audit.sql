-- Optional: Create LoginLog table for audit trail
-- Run this script to add login activity logging to your database

USE PortfolioDB;
GO

-- Create Login Log Table for Audit Trail
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LoginLog' AND xtype='U')
BEGIN
    CREATE TABLE LoginLog (
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL,
        Success BIT NOT NULL,
        Method NVARCHAR(50) NOT NULL, -- 'Manual Login', 'Auto-login via Remember Me', etc.
        IPAddress NVARCHAR(45), -- Supports both IPv4 and IPv6
        UserAgent NVARCHAR(500),
        LoginTime DATETIME NOT NULL DEFAULT GETDATE(),
        SessionID NVARCHAR(50),
        LogoutTime DATETIME NULL,
        SessionDuration INT NULL -- in minutes
    );

    -- Create index for performance
    CREATE INDEX IX_LoginLog_Username ON LoginLog(Username);
    CREATE INDEX IX_LoginLog_LoginTime ON LoginLog(LoginTime);
    
    PRINT 'LoginLog table created successfully';
END
ELSE
BEGIN
    PRINT 'LoginLog table already exists';
END
GO

-- Create Session Tracking Table (Optional)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ActiveSessions' AND xtype='U')
BEGIN
    CREATE TABLE ActiveSessions (
        SessionID NVARCHAR(50) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL,
        LoginTime DATETIME NOT NULL,
        LastActivity DATETIME NOT NULL,
        IPAddress NVARCHAR(45),
        UserAgent NVARCHAR(500),
        IsActive BIT NOT NULL DEFAULT 1
    );

    -- Create index for performance
    CREATE INDEX IX_ActiveSessions_Username ON ActiveSessions(Username);
    CREATE INDEX IX_ActiveSessions_LastActivity ON ActiveSessions(LastActivity);
    
    PRINT 'ActiveSessions table created successfully';
END
ELSE
BEGIN
    PRINT 'ActiveSessions table already exists';
END
GO

-- Sample queries to check login activity
PRINT 'Sample queries for login activity monitoring:';
PRINT '';
PRINT '-- View recent login attempts';
PRINT 'SELECT TOP 10 Username, Success, Method, IPAddress, LoginTime FROM LoginLog ORDER BY LoginTime DESC';
PRINT '';
PRINT '-- View failed login attempts';
PRINT 'SELECT Username, IPAddress, LoginTime FROM LoginLog WHERE Success = 0 ORDER BY LoginTime DESC';
PRINT '';
PRINT '-- View login statistics by user';
PRINT 'SELECT Username, COUNT(*) as TotalLogins, COUNT(CASE WHEN Success = 1 THEN 1 END) as SuccessfulLogins FROM LoginLog GROUP BY Username';
GO