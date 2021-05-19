-- Row lenght for Buffer Sizing calculations in SSIS

SELECT
    SUM (max_length)  [row_length]
FROM  sys.tables t
JOIN sys.columns c
    ON t.object_id=c.object_id
JOIN sys.schemas s
    ON t.schema_id=s.schema_id
WHERE t.name = ''
    AND s.name = ''