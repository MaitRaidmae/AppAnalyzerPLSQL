--------------------------------------------------------
--  DDL for Package Body P_RPREDICT_CHECK_PARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."P_RPREDICT_CHECK_PARS" 
IS
  -----------------------------------------------------------------------------
PROCEDURE UPDATE_ROW(
    PAR_RCP_CODE      NUMBER,
    PAR_RCP_TYPE      VARCHAR2,
    PAR_RCP_THRESHOLD NUMBER,
    PAR_RCP_CHK_CODE  NUMBER,
    PAR_RCP_MODEL     VARCHAR2)
IS

BEGIN
  UPDATE B_RPREDICT_CHECK_PARS
  SET RCP_TYPE    = PAR_RCP_TYPE,
    RCP_THRESHOLD = PAR_RCP_THRESHOLD,
    RCP_CHK_CODE  = PAR_RCP_CHK_CODE,
    RCP_MODEL     = PAR_RCP_MODEL
  WHERE RCP_CODE  = PAR_RCP_CODE;
END UPDATE_ROW;
-----------------------------------------------------------------------------

PROCEDURE GET_ROWS(
    PAR_FIELD_NAME IN VARCHAR2,
    PAR_KEY        IN NUMBER,
    PAR_RESULTS OUT SYS_REFCURSOR)
IS

  LC_SELECT VARCHAR2(2000);

BEGIN
  LC_SELECT := ' SELECT * FROM B_RPREDICT_CHECK_PARS WHERE '||par_field_name||' = :KEY';
  OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;

END GET_ROWS;
-----------------------------------------------------------------------------
END P_RPREDICT_CHECK_PARS;

/
