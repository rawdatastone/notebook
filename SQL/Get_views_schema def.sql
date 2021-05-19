-- Return a schema of a view for documentation excercises

SELECT 
	cu.VIEW_NAME,	
	c.TABLE_SCHEMA,
	c.TABLE_NAME,
	c.[COLUMN_NAME],
	DATA_TYPE,
	CASE 
    WHEN DATA_TYPE = 'int' THEN 4
    WHEN DATA_TYPE = 'datetime2' THEN 8
    WHEN DATA_TYPE = 'decimal' THEN 17
    WHEN DATA_TYPE = 'timestamp' THEN 8
    WHEN DATA_TYPE = 'varbinary' THEN 8000
    WHEN DATA_TYPE = 'varchar' THEN 4000
    WHEN DATA_TYPE = 'datetime' THEN 8
    WHEN DATA_TYPE = 'uniqueidentifier' THEN 16
    WHEN DATA_TYPE = 'tinyint' THEN 1
    WHEN DATA_TYPE = 'nchar' THEN 8000
    WHEN DATA_TYPE = 'char' THEN 8000
    WHEN DATA_TYPE = 'bigint' THEN 8
    WHEN DATA_TYPE = 'nvarchar' THEN 8000
    WHEN DATA_TYPE = 'bit' THEN 1
	ELSE '' 
END AS Size
FROM    INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS cu
JOIN    INFORMATION_SCHEMA.COLUMNS AS c
ON      c.TABLE_SCHEMA  = cu.TABLE_SCHEMA
AND     c.TABLE_CATALOG = cu.TABLE_CATALOG
AND     c.TABLE_NAME    = cu.TABLE_NAME
AND     c.COLUMN_NAME   = cu.COLUMN_NAME
WHERE   cu.VIEW_NAME    IN (
			

			
		)
	AND     cu.VIEW_SCHEMA  = 'mdm'
;

