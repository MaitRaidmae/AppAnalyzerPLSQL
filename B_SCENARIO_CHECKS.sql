--------------------------------------------------------
--  DDL for Table B_SCENARIO_CHECKS
--------------------------------------------------------

  CREATE TABLE "HUNDISILM"."B_SCENARIO_CHECKS" 
   (	"SCC_CODE" NUMBER(*,0), 
	"SCC_APL_CODE" VARCHAR2(20 BYTE), 
	"SCC_VALUE" VARCHAR2(20 BYTE), 
	"SCC_SRN_CODE" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HUNDISILM"."B_SCENARIO_CHECKS"."SCC_CODE" IS 'Primary key';
   COMMENT ON COLUMN "HUNDISILM"."B_SCENARIO_CHECKS"."SCC_APL_CODE" IS 'Application code to which the check belongs to.';
   COMMENT ON COLUMN "HUNDISILM"."B_SCENARIO_CHECKS"."SCC_VALUE" IS 'Result of the check.';
   COMMENT ON COLUMN "HUNDISILM"."B_SCENARIO_CHECKS"."SCC_SRN_CODE" IS 'Run code of the check.';
