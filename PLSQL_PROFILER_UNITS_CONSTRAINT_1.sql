--------------------------------------------------------
--  Constraints for Table PLSQL_PROFILER_UNITS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."PLSQL_PROFILER_UNITS" MODIFY ("TOTAL_TIME" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."PLSQL_PROFILER_UNITS" ADD PRIMARY KEY ("RUNID", "UNIT_NUMBER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
