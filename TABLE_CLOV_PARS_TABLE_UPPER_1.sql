--------------------------------------------------------
--  DDL for Trigger TABLE_CLOV_PARS#TABLE#UPPER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HUNDISILM"."TABLE_CLOV_PARS#TABLE#UPPER" 
BEFORE INSERT OR UPDATE OF TLP_TABLE ON B_TABLE_COL_LOV_PARS 

FOR EACH ROW
BEGIN
  :NEW.TLP_TABLE := UPPER(:NEW.TLP_TABLE);
END;
/
ALTER TRIGGER "HUNDISILM"."TABLE_CLOV_PARS#TABLE#UPPER" ENABLE;