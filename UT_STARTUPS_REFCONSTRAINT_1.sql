--------------------------------------------------------
--  Ref Constraints for Table UT_STARTUPS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_STARTUPS" ADD CONSTRAINT "UT_STARTUPS_LIB_VALIDN_FK1" FOREIGN KEY ("LIB_STARTUP_ID")
	  REFERENCES "HUNDISILM"."UT_LIB_STARTUPS" ("LIB_STARTUP_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "HUNDISILM"."UT_STARTUPS" ADD CONSTRAINT "UT_STARTUPS_SUITE_FK1" FOREIGN KEY ("UT_SID")
	  REFERENCES "HUNDISILM"."UT_SUITE" ("UT_SID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "HUNDISILM"."UT_STARTUPS" ADD CONSTRAINT "UT_STARTUPS_TEST_FK1" FOREIGN KEY ("UT_ID")
	  REFERENCES "HUNDISILM"."UT_TEST" ("UT_ID") ON DELETE CASCADE ENABLE;