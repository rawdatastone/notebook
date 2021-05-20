CREATE DATABASE SQLShackDSDemo  
ON   
( NAME = SQLShackDSDemo_dat,  
    FILENAME = 'c:\SQLDATA\SQLShackDSDemo_dat.mdf',  
    SIZE = 10,  
    MAXSIZE = 50,  
    FILEGROWTH = 5 )  
LOG ON  
( NAME = SQLShackDSDemo_log,  
    FILENAME = 'c:\SQLDATA\SQLShackDSDemo_log.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 5MB ) ;  
GO

USE SQLShackDSDemo;
GO
 
-- create a table SQLShackAuthorDS 
CREATE TABLE SQLShackAuthorDS (
    ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    authorName varchar(8000)
);
GO
 
-- create a stored procedure to generate 100 rows 
CREATE PROCEDURE InsertDataSP
AS
DECLARE @i int = 1
WHILE @i <=100
    BEGIN
        INSERT SQLShackAuthorDS (authorName) VALUES ('SQL Prashanth')
        Set @i =@i+1
    END
GO
EXECUTE InsertDataSP;
GO
SELECT * FROM SQLShackAuthorDS;
GO
