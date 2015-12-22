--------------------------------------------------------
--  DDL for Package P_CHECK_SUITS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_CHECK_SUITS" IS
-----------------------------------------------------------------------------
PROCEDURE UPDATE_ROW(
PAR_CHS_CODE NUMBER,
PAR_CHS_MNEMO VARCHAR2,
PAR_CHS_COMMENT VARCHAR2,
PAR_CHS_DATETIME TIMESTAMP);
-----------------------------------------------------------------------------

PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER,
PAR_RESULTS OUT SYS_REFCURSOR);
-----------------------------------------------------------------------------

PROCEDURE UPDATE_ROW_NVALUE(par_code NUMBER, par_column VARCHAR2, par_value NUMBER);
-----------------------------------------------------------------------------

PROCEDURE UPDATE_ROW_NVALUE(par_code NUMBER, par_column VARCHAR2, par_value VARCHAR2);
-----------------------------------------------------------------------------

PROCEDURE GET_RESULTS_PAGE(par_page_nr IN NUMBER, par_results_per_page IN NUMBER,
result_set OUT SYS_REFCURSOR, par_find_by_field VARCHAR2 DEFAULT NULL,
par_find_by_value NUMBER DEFAULT NULL);
-----------------------------------------------------------------------------

PROCEDURE INSERT_ROW(
par_chs_mnemo VARCHAR2,
par_chs_comment VARCHAR2,
par_chs_datetime TIMESTAMP
);
-----------------------------------------------------------------------------
END P_CHECK_SUITS;

/
