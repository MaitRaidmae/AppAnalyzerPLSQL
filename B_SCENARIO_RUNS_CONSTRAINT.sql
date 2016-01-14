--------------------------------------------------------
--  Constraints for Table B_SCENARIO_RUNS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_SCENARIO_RUNS" MODIFY ("SCR_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_RUNS" MODIFY ("SCR_SSC_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_RUNS" MODIFY ("SCR_SRN_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_RUNS" ADD CONSTRAINT "B_SCENARIO_RUNS_PK" PRIMARY KEY ("SCR_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
