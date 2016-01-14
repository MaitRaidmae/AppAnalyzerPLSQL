--------------------------------------------------------
--  DDL for Table UT_LOOKUP_VALUES
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."UT_LOOKUP_VALUES" 
   (	"ID" VARCHAR2(40 BYTE), 
	"DATA_ID" VARCHAR2(40 BYTE), 
	"VALUE" CLOB, 
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
  TABLESPACE "USERS" 
 LOB ("VALUE") STORE AS SECUREFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;