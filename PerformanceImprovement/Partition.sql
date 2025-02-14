Partition:
	Partitioning addresses key issues in supporting very large tables and indexes by letting you decompose them into smaller and more manageable pieces called partitions.
	Tables can be partitioned into up to 64,000 separate partitions. Any table can be partitioned except those tables containing columns with LONG or LONG RAW datatypes. You can, however, use tables containing columns with CLOB or BLOB datatypes.
	
Partition methods:



1. Range Partition: Partition will be based on a range.
	
	CREATE TABLE PLCY_TRNSCTN(PLCY_NBR VARCHAR2(20),JOB_NBR VARCHAR2(50),REGION VARCHAR2(20),AUDIT_TIMESTAMP DATE)
	PARTITION BY RANGE(AUDIT_TIMESTAMP)
	(PARTITION PARTITION_NAME1 VALUES LESS THAN (TO_DATE('01-JAN-2020','DD-MON-YYYY')) /* This partition will hold data before Jan 1st 2020*/
	PARTITION PARTITION_NAME2 VALUES LESS THAN (TO_DATE('01-JAN-2021','DD-MON-YYYY')) /* This partition will hold data before Jan 1st 2021*/
	PARTITION PARTITION_NAME3 VALUES LESS THAN (TO_DATE('01-JAN-2022','DD-MON-YYYY')) /* This partition will hold data before Jan 1st 2022*/
	PARTITION PARTITION_NAME4 VALUES LESS THAN (TO_DATE('01-JAN-2023','DD-MON-YYYY')) /* This partition will hold data before Jan 1st 2023*/
	PARTITION PARTITION_NAME5 VALUES LESS THAN (TO_DATE('01-JAN-2024','DD-MON-YYYY')) /* This partition will hold data before Jan 1st 2024*/
	PARTITION PARTITION_NAMELATEST VALUES LESS THAN (MAXVALUE)); /* This partition will hold latest data*/
	
	SELECT * FROM MYTABLE PARTITION(PARTITION_NAME) WHERE CONDITION='CONDITION';
	
2. List Partition: database uses a list of discrete values as the partition key for each partition.
	
	CREATE TABLE PLCY_TRNSCTN(PLCY_NBR VARCHAR2(20),JOB_NBR VARCHAR2(50),REGION VARCHAR2(20),AUDIT_TIMESTAMP DATE)
	PARITION BY LIST(REGION)
	(
	PARTITION PARTITION_EAST VALUES('EAST') /*East data will go to East partition*/
	PARTITION PARTITION_WEST VALUES('WEST') /*West data will go to West partition*/
	PARTITION PARTITION_SOUTH VALUES('SOUTH') /*South data will go to South partition*/
	PARTITION PARTITION_NORTH VALUES('NORTH') /*North data will go to North partition*/
	);

3. Hash Partition: Database maps rows to partition based on a hashing algorithm that the database applies to the user-specified parititoning key. Oracle will take care of partition.
	
	CREATE TABLE PLCY_TRNSCTN(PLCY_NBR VARCHAR2(20),JOB_NBR VARCHAR2(50),REGION VARCHAR2(20),AUDIT_TIMESTAMP DATE)
	PARITION BY HASH(PLCY_NBR)
	PARTITION 10; /*Number of partitions*/
	
4. Composite Partition: