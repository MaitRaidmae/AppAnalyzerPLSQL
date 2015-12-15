--------------------------------------------------------
--  DDL for Package Body P_CHECKS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."P_CHECKS" AS
--------------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW_NVALUE(par_chk_code NUMBER, par_column VARCHAR2, par_value NUMBER) AS
  BEGIN
    
    EXECUTE IMMEDIATE 
    'UPDATE b_checks
    set '||par_column||' = :value
    where chk_code = :par_chk_code' using par_value, par_chk_code;
    
  END UPDATE_ROW_NVALUE;
--------------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW_CVALUE(par_chk_code NUMBER, par_column VARCHAR2, par_value VARCHAR2) AS
  BEGIN
    
    EXECUTE IMMEDIATE 
    'UPDATE b_checks
    set '||par_column||' = :value
    where chk_code = :par_chk_code' using par_value,par_chk_code;
    
    
  END UPDATE_ROW_CVALUE;
--------------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW(
      par_chk_code     INTEGER,
      par_chk_mnemo    VARCHAR2,
      par_chk_type     VARCHAR2,
      par_chk_comment  VARCHAR2,
      par_chk_active   INTEGER,
      par_chk_chs_code INTEGER)
  IS
  
  BEGIN
    UPDATE b_checks
    SET chk_mnemo  = par_chk_mnemo,
      chk_type     = par_chk_type,
      chk_comment  = par_chk_comment,
      chk_active   = par_chk_active,
      chk_chs_code = par_chk_chs_code
    WHERE chk_code = par_chk_code;
  END UPDATE_ROW;
--------------------------------------------------------------------------------
PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER, 
  PAR_RESULTS OUT SYS_REFCURSOR) IS

LC_SELECT VARCHAR2(2000);

BEGIN

LC_SELECT := 'SELECT * FROM B_CHECKS WHERE '||par_field_name||' = :KEY';

OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;

END GET_ROWS;
--------------------------------------------------------------------------------
END P_CHECKS;

/
