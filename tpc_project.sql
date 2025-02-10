
CREATE DATABASE TPC;


drop table if exists InBound_Lks01_01_25;
create table if not exists InBound_Lks01_01_25 (
									POD_NO varchar(100),
									SYS_DT Date,
									SYS_TM time,
									MFSTNO varchar(100),
									ORIGIN varchar(4),
									DESTN varchar(4),
									REMARKS varchar(5)

								);

select * from InBound_Lks01_01_25


copy
InBound_Lks01_01_25(POD_NO,	SYS_DT,	SYS_TM,	MFSTNO,	ORIGIN,	DESTN,	REMARKS)
from 'F:\tpc/InBound_Lks01_01_25.csv'
delimiter','
csv header;


drop table if exists no_status;
create table if not exists no_status(
										POD_NO varchar(50),
										SYS_DT date,
										SYS_TM time,
										MFSTNO varchar(50),	
										ORIGIN varchar(5),
										DESTN varchar(5),
										REMARKS varchar(5)
										);

select * from no_status;

copy 
no_status(POD_NO,	SYS_DT,	SYS_TM,	MFSTNO,	ORIGIN,	DESTN,	REMARKS)
from 'F:/tpc/no_status.csv'
delimiter','
csv header;


drop table if exists DE_Lks01_01_25;
create table if not exists DE_Lks01_01_25(
											DRSNO varchar(50),
											POD_NO varchar(50),
											ORIGIN varchar(5),
											CC varchar(5),
											DESTN varchar(5),
											SYS_DT date,
											SYS_TM time,
											REMARKS varchar(3),
											WEIGHT decimal(5,2),	
											PIECES numeric(50),
											USERID varchar(10)
											);

select * from DE_Lks01_01_25;


alter table DE_Lks01_01_25
alter USERID type varchar(10)

copy 
DE_Lks01_01_25(DRSNO,	POD_NO,	ORIGIN,	CC,	DESTN,	SYS_DT,	SYS_TM,	REMARKS,	WEIGHT,	PIECES,	USERID)
from 'F:/tpc/DE_Lks01_01_25.csv'
delimiter','
csv header

copy 
TD_Lks01_01_25(DRSNO,	POD_NO,	ORIGIN,	CC,	DESTN,	SYS_DT,	SYS_TM,	REMARKS,	WEIGHT,	PIECES,	USERID)
from 'F:/tpc/TD_Lks01_01_25.csv'
delimiter','
csv header


-- General Queries
-- 1] Retrieve all records from each file.
-- 2] Display the count of unique POD_NO values in each file.
-- 3] Find all records where DESTN is "LKS" in each file.
-- 4] List records where SYS_DT is "01-01-2025".
-- 5] Retrieve all columns for POD_NO values starting with "BLR" in the second file.
-- Joining Tables
-- 6] Perform an inner join between the first and second files using POD_NO and display matching records.
-- 7] Find all POD_NO values present in the first file but not in the second.
-- 8] Retrieve all records from the second and third files where REMARKS match.
-- Aggregation and Analysis
-- 9] Calculate the total weight for each DESTN from the first file.
-- 10] Find the maximum number of PIECES in the first file.
-- 11] Count how many shipments (POD_NO) originated from "HBL" in the third file.
-- Filtering and Grouping
-- 12] Find all unique DRSNO values and their counts from the first file.
-- 13] Group records by ORIGIN and count the number of records in the second file.
-- 14] Filter records in the third file where REMARKS is "WE" and DESTN is "LKS".
-- Advanced Queries
-- 15] Display records with SYS_TM between "09:00:00" and "12:00:00" in all files.
-- 16] Identify and list POD_NO values common to all three files.
-- 17] Find the average weight for shipments in the first file where WEIGHT > 0.1.
-- 18] Modifications and Updates (hypothetical in practice)
-- 19] Simulate an update query to change REMARKS to "UPDATED" for shipments in the third file where ORIGIN is "BLR".
-- 20] Simulate deleting records where USERID is null in the first file.
-- Create a query to insert a new record into the second file with placeholder values.


-- 1] Retrieve all records from each file.
select * from TD_Lks01_01_25
select * from DE_Lks01_01_25
select * from no_status
select * from InBound_Lks01_01_25

-- 2] Display the count of unique POD_NO values in each file.
SELECT
	COUNT(DISTINCT POD_NO)
FROM
	TD_LKS01_01_25;

	
SELECT
	COUNT(POD_NO)
FROM
	DE_LKS01_01_25;


SELECT
	COUNT(POD_NO)
FROM
	NO_STATUS;


SELECT
	COUNT(DISTINCT POD_NO)
FROM
	INBOUND_LKS01_01_25;


-- 3] Find all records where DESTN is "LKS" in each file.

select * from INBOUND_LKS01_01_25
where DESTN = 'LKS';


select * from NO_STATUS
where DESTN = 'LKS';


select * from DE_LKS01_01_25
where DESTN = 'LKS';


select * from TD_LKS01_01_25
where DESTN = 'LKS';




-- 4] List records where SYS_DT is "01-01-2025".

select * from TD_LKS01_01_25
where SYS_DT= '01-01-2025';


select * from DE_LKS01_01_25
where SYS_DT = '01-01-2025';


select * from NO_STATUS
where SYS_DT= '01-01-2025';


select * from INBOUND_LKS01_01_25
where SYS_DT= '01-01-2025';


-- 5] Retrieve all columns for POD_NO values starting with "BLR" 
-- in the second file.

SELECT
	*
FROM
	INBOUND_LKS01_01_25
WHERE
	POD_NO LIKE 'BLR%'


-- 6] Perform an inner join between the first and second files using POD_NO
--    and display matching records.

SELECT
	*
FROM
	DE_LKS01_01_25
	INNER JOIN INBOUND_LKS01_01_25 ON DE_LKS01_01_25.POD_NO = INBOUND_LKS01_01_25.POD_NO;




-- 7] Find all POD_NO values present in the first file but not in the second.

SELECT
	*
FROM
	DE_LKS01_01_25
	JOIN INBOUND_LKS01_01_25 ON DE_LKS01_01_25.POD_NO = INBOUND_LKS01_01_25.POD_NO;	


-- 8] Retrieve all records from the second and third files where REMARKS match.

SELECT
	*
FROM
	INBOUND_LKS01_01_25
	JOIN NO_STATUS ON INBOUND_LKS01_01_25.REMARKS = NO_STATUS.REMARKS


-- 9] Calculate the total weight for each DESTN from the first file.

SELECT
	DESTN,
	SUM(WEIGHT) AS TOTAL
FROM
	DE_LKS01_01_25
GROUP BY
	DESTN;


-- 10] Find the maximum number of PIECES in the first file.

select DESTN, max(PIECES) as high
from DE_LKS01_01_25
group by DESTN