--------------------------------------------------------
--  DDL for Package P_CHECKS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_CHECKS" AS 

  /**
  *  Update a single value in a row
  *  par_code - primary key of the row to update.
  *  par_column - name of the column to update
  *  par_value - new value for the column
  */
  PROCEDURE UPDATE_ROW_NVALUE(par_chk_code NUMBER, par_column VARCHAR2, par_value NUMBER);
  PROCEDURE UPDATE_ROW_CVALUE(par_chk_code NUMBER, par_column VARCHAR2, par_value VARCHAR2);
  
  /**
  *  Update whole row in the table
  *
  */
  PROCEDURE UPDATE_ROW(PAR_CHK_CODE INTEGER, PAR_CHK_MNEMO VARCHAR2, PAR_CHK_TYPE VARCHAR2, PAR_CHK_COMMENT VARCHAR2, PAR_CHK_ACTIVE INTEGER, PAR_CHK_CHS_CODE INTEGER);
  /**
  *   Gets a row in the table based on key and returns a cursor;
  *
  *
  */
  PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER, 
  PAR_RESULTS OUT SYS_REFCURSOR);
END P_CHECKS;

/
