--------------------------------------------------------
--  Ref Constraints for Table UT_TEARDOWNS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_TEARDOWNS" ADD CONSTRAINT "UT_TEARDOWNS_LIB_VALIDN_FK1" FOREIGN KEY ("LIB_TEARDOWN_ID")
	  REFERENCES "HUNDISILM"."UT_LIB_TEARDOWNS" ("LIB_TEARDOWN_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "HUNDISILM"."UT_TEARDOWNS" ADD CONSTRAINT "UT_TEARDOWNS_SUITE_FK1" FOREIGN KEY ("UT_SID")
	  REFERENCES "HUNDISILM"."UT_SUITE" ("UT_SID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "HUNDISILM"."UT_TEARDOWNS" ADD CONSTRAINT "UT_TEARDOWNS_TEST_FK1" FOREIGN KEY ("UT_ID")
	  REFERENCES "HUNDISILM"."UT_TEST" ("UT_ID") ON DELETE CASCADE ENABLE;
