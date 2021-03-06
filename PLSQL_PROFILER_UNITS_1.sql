--------------------------------------------------------
--  DDL for Table PLSQL_PROFILER_UNITS
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."PLSQL_PROFILER_UNITS" 
   (	"RUNID" NUMBER, 
	"UNIT_NUMBER" NUMBER, 
	"UNIT_TYPE" VARCHAR2(32 BYTE), 
	"UNIT_OWNER" VARCHAR2(32 BYTE), 
	"UNIT_NAME" VARCHAR2(32 BYTE), 
	"UNIT_TIMESTAMP" DATE, 
	"TOTAL_TIME" NUMBER DEFAULT 0, 
	"SPARE1" NUMBER, 
	"SPARE2" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
