--------------------------------------------------------
--  DDL for Table UT_LIB_TEARDOWNS
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."UT_LIB_TEARDOWNS" 
   (	"LIB_TEARDOWN_ID" VARCHAR2(40 BYTE), 
	"LIB_TEARDOWN_NAME" VARCHAR2(120 BYTE), 
	"LIB_TEARDOWN_CLASS" VARCHAR2(120 BYTE), 
	"LIB_TEARDOWN" CLOB, 
	"CREATED_ON" TIMESTAMP (6), 
	"CREATED_BY" VARCHAR2(120 BYTE), 
	"UPDATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(120 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" 
 LOB ("LIB_TEARDOWN") STORE AS SECUREFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;
