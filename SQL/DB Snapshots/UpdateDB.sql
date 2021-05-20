-- update records to the source database
USE SQLShackDSDemo;
GO
update SQLShackAuthorDS
SET authorName='SQLShack Prashanth'
where id<50
GO
SELECT * FROM SQLShackAuthorDS;
GO