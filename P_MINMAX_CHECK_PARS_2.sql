--------------------------------------------------------
--  DDL for Package P_MINMAX_CHECK_PARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_MINMAX_CHECK_PARS" 
IS
  ------------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW(
      par_mcp_code        NUMBER,
      par_mcp_chk_code    NUMBER,
      par_mcp_threshold   NUMBER,
      par_mcp_check_field VARCHAR2);
  ------------------------------------------------------------------------------
  PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER, 
  PAR_RESULTS OUT SYS_REFCURSOR);
  ------------------------------------------------------------------------------
  PROCEDURE INSERT_ROW(
    par_mcp_chk_code    NUMBER,
    par_mcp_threshold   NUMBER,
    par_mcp_check_field VARCHAR2);
  ------------------------------------------------------------------------------
END P_MINMAX_CHECK_PARS;

/
