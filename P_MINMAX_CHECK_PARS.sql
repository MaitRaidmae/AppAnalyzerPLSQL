--------------------------------------------------------
--  DDL for Package P_MINMAX_CHECK_PARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_MINMAX_CHECK_PARS" 
IS
  ------------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW(
      PAR_MCP_CODE        NUMBER,
      PAR_MCP_CHK_CODE    NUMBER,
      PAR_MCP_THRESHOLD   NUMBER,
      PAR_MCP_CHECK_FIELD VARCHAR2);
  ------------------------------------------------------------------------------
  PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER, 
  PAR_RESULTS OUT SYS_REFCURSOR);
  ------------------------------------------------------------------------------
  
END P_MINMAX_CHECK_PARS;

/
