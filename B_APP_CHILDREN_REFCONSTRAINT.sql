--------------------------------------------------------
--  Ref Constraints for Table B_APP_CHILDREN
--------------------------------------------------------

  ALTER TABLE "HUNDISILM"."B_APP_CHILDREN" ADD CONSTRAINT "B_APP_CHILDREN_FK1" FOREIGN KEY ("ACH_ACO_CODE")
	  REFERENCES "HUNDISILM"."B_APP_CONTROLLERS" ("ACO_CODE") ON DELETE CASCADE ENABLE;
