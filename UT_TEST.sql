--------------------------------------------------------
--  DDL for Table UT_TEST
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."UT_TEST" 
   (	"UT_ID" VARCHAR2(40 BYTE), 
	"NAME" VARCHAR2(120 BYTE), 
	"OBJECT_NAME" VARCHAR2(120 BYTE), 
	"OBJECT_TYPE" VARCHAR2(120 BYTE), 
	"OBJECT_OWNER" VARCHAR2(120 BYTE), 
	"OBJECT_CALL" VARCHAR2(120 BYTE), 
	"CONNECTION_NAME" VARCHAR2(120 BYTE), 
	"COVERAGE" NUMBER(1,0), 
	"CREATED_ON" TIMESTAMP (6), 
	"CREATED_BY" VARCHAR2(120 BYTE), 
	"UPDATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(120 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
