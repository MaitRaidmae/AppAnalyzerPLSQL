--------------------------------------------------------
--  Constraints for Table B_MINMAX_ITERATORS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_CODE" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_MNEMO" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_FIELD" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_THRESHOLD_FROM" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_THRESHOLD_TO" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" ADD CONSTRAINT "B_MINMAX_ITERATORS_PK" PRIMARY KEY ("MMI_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."B_MINMAX_ITERATORS" MODIFY ("MMI_STEP" NOT NULL ENABLE);
