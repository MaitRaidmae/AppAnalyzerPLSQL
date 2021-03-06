--------------------------------------------------------
--  Constraints for Table B_CHECKS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_CHECKS" ADD CONSTRAINT "B_CHECKS_CHK_ACTIVE_BOOLEAN" CHECK (CHK_ACTIVE = 0 or CHK_ACTIVE = 1) ENABLE;
  ALTER TABLE "HUNDISILM"."B_CHECKS" ADD CONSTRAINT "B_CHECKS_PK" PRIMARY KEY ("CHK_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."B_CHECKS" ADD CONSTRAINT "B_CHECKS_UK1" UNIQUE ("CHK_MNEMO", "CHK_CHS_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."B_CHECKS" MODIFY ("CHK_MNEMO" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_CHECKS" MODIFY ("CHK_TYPE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_CHECKS" MODIFY ("CHK_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_CHECKS" MODIFY ("CHK_ACTIVE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_CHECKS" ADD CONSTRAINT "B_CHECKS#CHK_TYPE#LOV" CHECK ("CHK_TYPE"='MIN' OR "CHK_TYPE"='MAX' OR "CHK_TYPE"='FORBIDDEN_LOV' OR "CHK_TYPE"='ALLOWED_LOV' OR "CHK_TYPE"='RPREDICT') ENABLE;
