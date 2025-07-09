 CREATE OR REPLACE STORAGE INTEGRATION PBI_Integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::906229884180:role/powerbiprojectrole'
  STORAGE_ALLOWED_LOCATIONS = ('s3://powerbi.projectttt/')
  COMMENT = 'Optional Comment'


  //description Integration Object
  desc integration PBI_Integration;

//drop integration PBI_Integration



--------------------------------------------
//drop database PowerBI

CREATE database PowerBI;

create schema PBI_Data;

create table PBI_Dataset (
Year int,	Location string,	Area	int,
Rainfall	float, Temperature	float, Soil_type string,
Irrigation	string, yeilds	int,Humidity	float,
Crops	string,price	int,Season string



);

select * from PBI_Dataset;

//drop database test;

create stage PowerBI.PBI_Data.pbi_stage
url = 's3://powerbi.projectttt'
storage_integration = PBI_Integration

//desc stage s1

//drop stage s1;


copy into PBI_Dataset 
from @pbi_stage
file_format = (type=csv field_delimiter=',' skip_header=1 )
on_error = 'continue'

list @pbi_stage

create table agriculture as
select * from PBI_DATASET


select * from agriculture;

update agriculture set rainfall = 1.1*rainfall;

update agriculture set area = 0.9*area;

// year 2004 - 2009 - Y1
//year 2010 - 2015 - Y2
//year 2016 - 2019 - Y3

alter table agriculture
add Year_group string;

update agriculture 
set Year_group = 'Y1'
where year>=2004 and year <=2009;

update agriculture 
set Year_group = 'Y2'
where year>=2010 and year <=2015;

update agriculture 
set Year_group = 'Y3'
where year>=2016 and year <=2019;

select * from agriculture;

//adding rainfall groups
alter table agriculture
add Rainfall_group string;

update agriculture
set Rainfall_group = 'low'
where rainfall>=255 and rainfall<=1200;

update agriculture
set Rainfall_group = 'medium'
where rainfall>1200 and rainfall<=2800;

update agriculture
set Rainfall_group = 'high'
where rainfall>2800 ;

select * from agriculture;











