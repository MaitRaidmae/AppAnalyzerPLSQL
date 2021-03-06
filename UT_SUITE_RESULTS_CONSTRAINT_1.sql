--------------------------------------------------------
--  Constraints for Table UT_SUITE_RESULTS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("UTSR_ID" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("UT_SID" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("STATUS" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("COVERAGE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("RUN_DATE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("CREATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("UPDATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" MODIFY ("UPDATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_SUITE_RESULTS" ADD CONSTRAINT "UT_SUITE_RESULTS_PK" PRIMARY KEY ("UTSR_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
