--Query the Snapshot 
USE SQLShackDSDemo_Snapshot;
GO
SELECT * FROM SQLShackAuthorDS;
GO

/*
Query the system catalog to get the size of the sparse file.

select the is_sparse column from either 
	sys.database_files in the database snapshot or 
	sys.master_files. 
	
	This is a boolean flag-like indicator:

    1 = File is a sparse file.
    0 = File is not a sparse file. 
*/


SELECT  DB_NAME(sd.source_database_id) AS [SourceDatabase], 
        sd.name AS [Snapshot],
        mf.name AS [Filename], 
        size_on_disk_bytes/1024 AS [size_on_disk (KB)],
        mf2.size/128 AS [MaximumSize (MB)]
FROM sys.master_files mf
JOIN sys.databases sd
    ON mf.database_id = sd.database_id
JOIN sys.master_files mf2
    ON sd.source_database_id = mf2.database_id
    AND mf.file_id = mf2.file_id
CROSS APPLY sys.dm_io_virtual_file_stats(sd.database_id, mf.file_id)
WHERE mf.is_sparse = 1
AND mf2.is_sparse = 0
ORDER BY 1;