-- To fetch the logical name of a data file
SELECT name, physical_name, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'SQLShackDSDemo');