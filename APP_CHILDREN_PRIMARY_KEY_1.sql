--------------------------------------------------------
--  DDL for Trigger APP_CHILDREN#PRIMARY_KEY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HUNDISILM"."APP_CHILDREN#PRIMARY_KEY" 
   before insert on "HUNDISILM"."B_APP_CHILDREN" 
   for each row 
begin  
   if inserting then 
      if :NEW."ACH_CODE" is null then 
         select APP_CHILDREN#ACH_CODE.nextval into :NEW."ACH_CODE" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "HUNDISILM"."APP_CHILDREN#PRIMARY_KEY" ENABLE;
