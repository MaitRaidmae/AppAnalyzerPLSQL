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
    par_mcp_check_field VARCHAR2)
IS

BEGIN
  UPDATE B_MINMAX_CHECK_PARS
  SET mcp_chk_code = par_mcp_chk_code, mcp_threshold = par_mcp_threshold, mcp_check_field = par_mcp_check_field
  WHERE mcp_code   = par_mcp_code;
END UPDATE_ROW;
--------------------------------------------------------------------------------
PROCEDURE GET_ROWS(
    PAR_FIELD_NAME IN VARCHAR2,
    PAR_KEY        IN NUMBER,
    PAR_RESULTS OUT SYS_REFCURSOR)
IS

  LC_SELECT VARCHAR2(2000);

BEGIN

  LC_SELECT := 'SELECT * FROM B_MINMAX_CHECK_PARS WHERE '||par_field_name||' = :KEY';

  OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;

END GET_ROWS;
--------------------------------------------------------------------------------
PROCEDURE INSERT_ROW(
    par_mcp_chk_code  NUMBER,
    par_mcp_threshold NUMBER,
    par_mcp_check_field VARCHAR2)
IS

BEGIN

  INSERT
  INTO b_minmax_check_pars
    (
      mcp_chk_code, mcp_threshold, mcp_check_field
    )
    VALUES
    (
      par_mcp_chk_code, par_mcp_threshold, par_mcp_check_field
    );

END INSERT_ROW;
--------------------------------------------------------------------------------
END P_MINMAX_CHECK_PARS;

/
