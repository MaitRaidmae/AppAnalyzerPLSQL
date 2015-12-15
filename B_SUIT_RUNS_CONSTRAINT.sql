--------------------------------------------------------
--  Constraints for Table B_SUIT_RUNS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_SUIT_RUNS" MODIFY ("SRN_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SUIT_RUNS" MODIFY ("SRN_CHS_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SUIT_RUNS" MODIFY ("SRN_DATE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SUIT_RUNS" ADD CONSTRAINT "B_SUIT_RUNS_PK" PRIMARY KEY ("SRN_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
