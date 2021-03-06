--------------------------------------------------------
--  DDL for Table B_TABLE_COL_LOV_PARS
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."B_TABLE_COL_LOV_PARS" 
   (	"TLP_CODE" NUMBER(*,0), 
	"TLP_TABLE" VARCHAR2(200 BYTE), 
	"TLP_COLUMN" VARCHAR2(200 BYTE), 
	"TLP_SELECT_SQL" VARCHAR2(2000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HUNDISILM"."B_TABLE_COL_LOV_PARS"."TLP_CODE" IS 'Primary key';
   COMMENT ON COLUMN "HUNDISILM"."B_TABLE_COL_LOV_PARS"."TLP_TABLE" IS 'Table name which this applies to.';
   COMMENT ON COLUMN "HUNDISILM"."B_TABLE_COL_LOV_PARS"."TLP_COLUMN" IS 'Column to which this applies to.';
   COMMENT ON COLUMN "HUNDISILM"."B_TABLE_COL_LOV_PARS"."TLP_SELECT_SQL" IS 'SQL Statement which gets the LOV for the column.';
