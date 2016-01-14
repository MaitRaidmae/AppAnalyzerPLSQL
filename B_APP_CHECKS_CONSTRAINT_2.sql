--------------------------------------------------------
--  Constraints for Table B_APP_CHECKS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" ADD CONSTRAINT "B_APP_CHECKS_CHK1" CHECK (ACk_value in (-1,0,1)) ENABLE;
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" ADD PRIMARY KEY ("ACK_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" MODIFY ("ACK_APL_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" MODIFY ("ACK_CHK_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" MODIFY ("ACK_VALUE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" MODIFY ("ACK_SRN_CODE" NOT NULL ENABLE);