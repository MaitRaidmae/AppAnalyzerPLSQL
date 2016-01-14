--------------------------------------------------------
--  Constraints for Table B_RUN_STATS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_SRN_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_TOTAL_APPLS" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_TOTAL_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_ACCEPTED_APPLS" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" MODIFY ("RST_ACCEPTED_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_RUN_STATS" ADD CONSTRAINT "B_RUN_STATS_PK" PRIMARY KEY ("RST_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
