--------------------------------------------------------
--  DDL for Package P_RPREDICT_CHECK_PARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_RPREDICT_CHECK_PARS" 
IS
  -----------------------------------------------------------------------------
  PROCEDURE UPDATE_ROW(
      PAR_RCP_CODE      NUMBER,
      PAR_RCP_TYPE      VARCHAR2,
      PAR_RCP_THRESHOLD NUMBER,
      PAR_RCP_CHK_CODE  NUMBER,
      PAR_RCP_MODEL     VARCHAR2);
  -----------------------------------------------------------------------------

  PROCEDURE GET_ROWS(
      PAR_FIELD_NAME IN VARCHAR2,
      PAR_KEY        IN NUMBER,
      PAR_RESULTS OUT SYS_REFCURSOR);
  -----------------------------------------------------------------------------
END P_RPREDICT_CHECK_PARS;

/
