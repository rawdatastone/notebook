-- To create a database snapshot SQLShackDSDemo_Snapshot, source database SQLShackDSDemo
 
CREATE DATABASE SQLShackDSDemo_Snapshot
ON (NAME = SQLShackDSDemo_dat, FILENAME = 'C:\SQLSnapshots\SQLShackDSDemo_SnapshotData.snap')
AS SNAPSHOT OF SQLShackDSDemo;
GO