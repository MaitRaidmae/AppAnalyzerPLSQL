--------------------------------------------------------
--  DDL for Package Body P_MINMAX_CHECK_PARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."P_MINMAX_CHECK_PARS" 
IS
  --------------------------------------------------------------------------------
PROCEDURE UPDATE_ROW(
    PAR_MCP_CODE        NUMBER,
    PAR_MCP_CHK_CODE    NUMBER,
    PAR_MCP_THRESHOLD   NUMBER,
    PAR_MCP_CHECK_FIELD VARCHAR2)
IS

BEGIN
  UPDATE B_MINMAX_CHECK_PARS
  SET MCP_CHK_CODE  = PAR_MCP_CHK_CODE,
    MCP_THRESHOLD   = PAR_MCP_THRESHOLD,
    MCP_CHECK_FIELD = PAR_MCP_CHECK_FIELD
  WHERE MCP_CODE    = PAR_MCP_CODE;
END UPDATE_ROW;
--------------------------------------------------------------------------------
PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER, 
  PAR_RESULTS OUT SYS_REFCURSOR) IS

LC_SELECT VARCHAR2(2000);

BEGIN

LC_SELECT := 'SELECT * FROM B_MINMAX_CHECK_PARS WHERE '||par_field_name||' = :KEY';

OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;

END GET_ROWS;

END P_MINMAX_CHECK_PARS;

/
