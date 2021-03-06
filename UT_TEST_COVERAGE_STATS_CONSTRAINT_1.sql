--------------------------------------------------------
--  Constraints for Table UT_TEST_COVERAGE_STATS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" MODIFY ("CREATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" MODIFY ("UPDATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" MODIFY ("UPDATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" ADD CONSTRAINT "UT_TEST_COVERAGE_STATS_PK" PRIMARY KEY ("UTC_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
