

SELECT T.*,
DDDPA.partition_id AS partition_number,
ISNULL
(
CAST(LEFT_PRV.value AS VARCHAR(MAX)) +
CASE WHEN PF.boundary_value_on_right = 0 THEN ' < ' ELSE ' <= ' END ,
'-INF < '
) +
'X' +
ISNULL
(
CASE WHEN PF.boundary_value_on_right = 0 THEN ' <= ' ELSE ' < ' END +
CAST(RIGHT_PRV.value AS NVARCHAR(MAX)),
' < INF'
) AS range_desc,
PF.boundary_value_on_right
FROM dbo.LeftTable AS T
CROSS APPLY sys.fn_PhysLocCracker(T.%%physloc%%) AS FPLC
JOIN sys.dm_db_database_page_allocations(DB_ID(),NULL,NULL,NULL,NULL) AS DDDPA
ON DDDPA.allocated_page_page_id = FPLC.page_id
AND DDDPA.allocated_page_file_id = FPLC.file_id
JOIN sys.indexes AS I
ON DDDPA.object_id = I.object_id
AND DDDPA.index_id = I.index_id
LEFT JOIN sys.partition_schemes PS
ON PS.data_space_id = I.data_space_id
LEFT JOIN sys.partition_functions pf
ON ps.function_id = pf.function_id
LEFT JOIN sys.partition_range_values left_prv
ON left_prv.function_id = ps.function_id
AND left_prv.boundary_id + 1 = DDDPA.partition_id
LEFT JOIN sys.partition_range_values right_prv
ON right_prv.function_id = ps.function_id
AND right_prv.boundary_id = DDDPA.partition_id;