--------------------------------------------------------
--  Constraints for Table B_SCENARIO_CHECK_PARS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" ADD CONSTRAINT "B_SCENARIO_CHECK_PARS_PK" PRIMARY KEY ("SCP_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_CHK_MNEMO" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_CHK_TYPE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_PAR_NAME" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_PAR_VALUE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_SRN_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_SSC_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" MODIFY ("SCP_TYPE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_SCENARIO_CHECK_PARS" ADD CONSTRAINT "B_SCENARIO_CHECK_PARS_CHK1" CHECK (SCP_TYPE = 'BASE' OR SCP_TYPE = 'ITERATION') ENABLE;