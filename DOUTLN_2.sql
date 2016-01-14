--------------------------------------------------------
--  DDL for Procedure DOUTLN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HUNDISILM"."DOUTLN" (par_string varchar2) IS
BEGIN
  dbms_output.put_line(par_string);
end;

/
