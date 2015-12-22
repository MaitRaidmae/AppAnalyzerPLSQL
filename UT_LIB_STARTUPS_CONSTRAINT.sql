--------------------------------------------------------
--  Constraints for Table UT_LIB_STARTUPS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("LIB_STARTUP_ID" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("LIB_STARTUP_NAME" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("LIB_STARTUP_CLASS" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("LIB_STARTUP" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("CREATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("UPDATED_ON" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" MODIFY ("UPDATED_BY" NOT NULL ENABLE);
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" ADD CONSTRAINT "UT_LIB_STARTUPS_PK" PRIMARY KEY ("LIB_STARTUP_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "HUNDISILM"."UT_LIB_STARTUPS" ADD CONSTRAINT "UT_LIB_STARTUPS_NAME" UNIQUE ("LIB_STARTUP_NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;