--------------------------------------------------------
--  Ref Constraints for Table B_APP_CHECKS
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" ADD CONSTRAINT "B_APP_CHECKS_FK1" FOREIGN KEY ("ACK_CHK_CODE")
	  REFERENCES "HUNDISILM"."B_CHECKS" ("CHK_CODE") ENABLE;
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" ADD CONSTRAINT "B_APP_CHECKS_FK2" FOREIGN KEY ("ACK_APL_CODE")
	  REFERENCES "HUNDISILM"."B_APPLICATIONS" ("APL_CODE") ENABLE;
  ALTER TABLE "HUNDISILM"."B_APP_CHECKS" ADD CONSTRAINT "B_APP_CHECKS_FK3" FOREIGN KEY ("ACK_SRN_CODE")
	  REFERENCES "HUNDISILM"."B_SUIT_RUNS" ("SRN_CODE") ENABLE;
