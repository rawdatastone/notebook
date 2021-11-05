-- Learning how to use partitioning of tables on a database called Test 
-- Just create a new empty database

USE Test;
GO

-- Create filegroups
ALTER DATABASE Test ADD FILEGROUP OrdersLatestFg1;
GO

ALTER DATABASE Test ADD FILE (  
    NAME = OrdersLatestFg1dat,  
    FILENAME = 'F:\SQL Data\OrdersLatestFg1dat.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB
    )  
TO FILEGROUP OrdersLatestFg1;
GO

ALTER DATABASE Test ADD FILEGROUP OrdersLatestFg2;
GO

ALTER DATABASE Test ADD FILE (  
    NAME = OrdersLatestFg2dat,  
    FILENAME = 'F:\SQL Data\OrdersLatestFg2dat.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB
    )  
TO FILEGROUP OrdersLatestFg2;
GO
ALTER DATABASE Test ADD FILEGROUP OrdersLatestFg3;
GO

ALTER DATABASE Test ADD FILE (  
    NAME = OrdersLatestFg3dat,  
    FILENAME = 'F:\SQL Data\OrdersLatestFg3dat.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB
    )  
TO FILEGROUP OrdersLatestFg3;
GO
ALTER DATABASE Test ADD FILEGROUP OrdersLatestFg4;
GO

ALTER DATABASE Test ADD FILE (  
    NAME = OrdersLatestFg4dat,  
    FILENAME = 'F:\SQL Data\OrdersLatestFg4dat.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB
    )  
TO FILEGROUP OrdersLatestFg4;
GO

-- Create a partition function that will result in four partitions  
CREATE PARTITION FUNCTION OrdersLatestPartitionFunction (date)  
    AS RANGE RIGHT FOR VALUES (
        '20200201', 
        '20200301',
        '20200401'
    );
GO

-- Create a partition scheme that maps the partitions to the filegroups
CREATE PARTITION SCHEME OrdersLatestPartitionScheme
    AS PARTITION OrdersLatestPartitionFunction  
    TO (
        OrdersLatestFg1,
        OrdersLatestFg2,
        OrdersLatestFg3,
        OrdersLatestFg4
        );  
GO

DROP TABLE IF EXISTS OrdersLatest;
GO
-- Create a partitioned table called OrdersLatest that uses the OrderDate column as the partitioning column
CREATE TABLE OrdersLatest (
    OrderDate date NOT NULL,
    OrderId int IDENTITY NOT NULL,
    OrderDesc varchar(255) NOT NULL,
    CONSTRAINT PKOrdersLatest PRIMARY KEY CLUSTERED(OrderDate, OrderId)
    )  
    ON OrdersLatestPartitionScheme(OrderDate);  
GO

-- Insert data into the OrdersLatest table. 
-- This will end up in partition 3, which is the partition we will switch out to the OrdersMarch table.
INSERT INTO OrdersLatest(OrderDate, OrderDesc) VALUES
    ('20200302', 'Cat food'),
    ('20200315', 'Water bowl'),
    ('20200318', 'Saddle for camel'),
    ('20200321', 'Dog biscuits'),
    ('20200328', 'Bigfoot shoes');
GO

-- Create a table that contains the data that we will be switching out to.  
-- Note that the filegroup matches the filegroup of the partition that we will switch out of.
DROP TABLE IF EXISTS OrdersMarch;
GO
CREATE TABLE OrdersMarch (
    OrderDate date NOT NULL,
    OrderId int IDENTITY NOT NULL,
    OrderDesc varchar(255) NOT NULL,
    CONSTRAINT PKOrdersMarch PRIMARY KEY CLUSTERED(OrderDate, OrderId)
    )
    ON OrdersLatestFg3;
GO

------------------------------------------------------------------------
-- Check how many rows are in each table
SELECT COUNT(*) AS OrdersLatest
FROM OrdersLatest;

SELECT COUNT(*) AS OrdersMarch 
FROM OrdersMarch;

------------------------------------------------------------------------
SELECT 
    p.partition_number AS [Partition], 
    fg.name AS [Filegroup], 
    p.Rows
FROM sys.partitions p
    INNER JOIN sys.allocation_units au
    ON au.container_id = p.hobt_id
    INNER JOIN sys.filegroups fg
    ON fg.data_space_id = au.data_space_id
WHERE p.object_id = OBJECT_ID('OrdersLatest')
ORDER BY [Partition];


SELECT 
    p.partition_number AS [Partition], 
    fg.name AS [Filegroup], 
    p.Rows
FROM sys.partitions p
    INNER JOIN sys.allocation_units au
    ON au.container_id = p.hobt_id
    INNER JOIN sys.filegroups fg
    ON fg.data_space_id = au.data_space_id
WHERE p.object_id = OBJECT_ID('OrdersMarch')
ORDER BY [Partition];
------------------------------------------------------------------------
INSERT INTO OrdersLatest(OrderDate, OrderDesc) VALUES
    ('20200202', 'Cat food'),
    ('20200215', 'Water bowl'),
    ('20200218', 'Saddle for camel'),
    ('20200221', 'Dog biscuits'),
    ('20200228', 'Bigfoot shoes');
GO
-------------------------------------------------------------------------
ALTER TABLE OrdersLatest
SWITCH PARTITION 3 TO OrdersMarch;

SELECT 
    p.partition_number AS [Partition], 
    fg.name AS [Filegroup], 
    p.Rows
FROM sys.partitions p
    INNER JOIN sys.allocation_units au
    ON au.container_id = p.hobt_id
    INNER JOIN sys.filegroups fg
    ON fg.data_space_id = au.data_space_id
WHERE p.object_id = OBJECT_ID('OrdersLatest')
ORDER BY [Partition];


SELECT 
    p.partition_number AS [Partition], 
    fg.name AS [Filegroup], 
    p.Rows
FROM sys.partitions p
    INNER JOIN sys.allocation_units au
    ON au.container_id = p.hobt_id
    INNER JOIN sys.filegroups fg
    ON fg.data_space_id = au.data_space_id
WHERE p.object_id = OBJECT_ID('OrdersMarch')
ORDER BY [Partition];
--------------------------------------------------
-- Moving another partition, should not work, right? 
ALTER TABLE OrdersLatest
SWITCH PARTITION 2 TO OrdersMarch;
--Output
--ALTER TABLE SWITCH statement failed. The target table 'Test.dbo.OrdersMarch' must be empty.

--So is the problem in contents only? Or would it fail if table was empty? 

--Output
--ALTER TABLE SWITCH statement failed. index 'Test.dbo.OrdersMarch.PKOrdersMarch' is in filegroup 'OrdersLatestFg3' and partition 2 of index 'Test.dbo.OrdersLatest.PKOrdersLatest' is in filegroup 'OrdersLatestFg2'.
CREATE TABLE OrdersMarch (
    OrderDate date NOT NULL,
    OrderId int IDENTITY NOT NULL,
    OrderDesc varchar(255) NOT NULL,
    CONSTRAINT PKOrdersMarch PRIMARY KEY CLUSTERED(OrderDate, OrderId)
    )
    ON OrdersLatestFg2;
GO