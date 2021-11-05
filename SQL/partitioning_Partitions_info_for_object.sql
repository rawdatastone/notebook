use RDD_DW;
GO

SELECT
	part.partition_number, 
	part.rows,
	sum(alloc.total_pages/128) AS TotalTableSizeInMB,
	sum(alloc.used_pages/128) AS UsedSizeInMB,
	sum(alloc.data_pages/128) AS DataSizeInMB
FROM sys.allocation_units AS alloc
	INNER JOIN sys.partitions AS part 
		ON alloc.container_id = CASE 
									WHEN alloc.type in(1,3) THEN part.hobt_id 
									ELSE part.partition_id 
								END
	LEFT JOIN sys.indexes AS idx 
		ON idx.object_id = part.object_id 
			AND idx.index_id = part.index_id
where 
	part.object_id = object_id('')
group by 
	partition_number, rows



select 
	top(10) * 
from  sys.partitions 
where OBJECT_ID = object_id('<schema>.<name>')