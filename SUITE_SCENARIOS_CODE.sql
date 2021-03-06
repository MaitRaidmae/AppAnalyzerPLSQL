--------------------------------------------------------
--  DDL for Trigger SUITE_SCENARIOS#CODE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HUNDISILM"."SUITE_SCENARIOS#CODE" before
  INSERT ON "B_SUITE_SCENARIOS" FOR EACH row BEGIN IF inserting THEN IF :NEW."SSC_CODE" IS NULL THEN
  SELECT SUITE_SCENARIOS#SSC_CODE.nextval INTO :NEW."SSC_CODE" FROM dual;
END IF;
END IF;
END;
/
ALTER TRIGGER "HUNDISILM"."SUITE_SCENARIOS#CODE" ENABLE;
