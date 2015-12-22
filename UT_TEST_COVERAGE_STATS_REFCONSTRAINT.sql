--------------------------------------------------------
--  Ref Constraints for Table UT_TEST_COVERAGE_STATS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" ADD CONSTRAINT "UT_TEST_COV_STATS_UT_T_FK1" FOREIGN KEY ("UTI_ID")
	  REFERENCES "HUNDISILM"."UT_TEST_IMPL" ("UTI_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "HUNDISILM"."UT_TEST_COVERAGE_STATS" ADD CONSTRAINT "UT_TEST_COV_STATS_UT_T_FK2" FOREIGN KEY ("UTIR_ID")
	  REFERENCES "HUNDISILM"."UT_TEST_IMPL_RESULTS" ("UTIR_ID") ON DELETE CASCADE ENABLE;