--------------------------------------------------------
--  Ref Constraints for Table B_SUIT_RUNS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_SUIT_RUNS" ADD CONSTRAINT "B_SUIT_RUNS_FK1" FOREIGN KEY ("SRN_CHS_CODE")
	  REFERENCES "HUNDISILM"."B_CHECK_SUITS" ("CHS_CODE") ON DELETE CASCADE ENABLE;
