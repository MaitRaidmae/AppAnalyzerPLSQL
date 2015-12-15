--------------------------------------------------------
--  DDL for Package CODE_SYNTH_HELPERS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."CODE_SYNTH_HELPERS" 
IS

  -- define collection type for storing parameters and their
TYPE gt_type_map
IS
  TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(50);
  gr_par_type_map gt_type_map;
  --------------------------------------------------------------------------------
  CURSOR cTabCols(p_table_name VARCHAR2)
  is
    ( SELECT * FROM user_tab_cols WHERE table_name=upper(p_table_name) AND Column_id is not null
    ) ;
  rTabCols cTabCols%ROWTYPE;
  --------------------------------------------------------------------------------
  PROCEDURE MAP_PARS(
      par_table_name VARCHAR2);
  --------------------------------------------------------------------------------
  FUNCTION SNAKE_TO_CAMEL(
      par_string VARCHAR2,
      par_lower_init boolean default false)
    RETURN VARCHAR2;
  --------------------------------------------------------------------------------
  FUNCTION COL_TAG(
      par_fxid VARCHAR2,
      par_text VARCHAR2)
    RETURN XMLTYPE;
  --------------------------------------------------------------------------------
  PROCEDURE ADD_LN(
      par_clob    IN OUT CLOB,
      par_string2 IN VARCHAR2);
  --------------------------------------------------------------------------------
  FUNCTION CAMEL_TABLENAME_WOB(
      par_table_name VARCHAR2,
      par_lower_init boolean default false)
    RETURN VARCHAR2;
  --------------------------------------------------------------------------------
  FUNCTION TABLE_PAR_LIST(
      par_table_name    VARCHAR2,
      par_variable_name VARCHAR2)
    RETURN VARCHAR2;
  --------------------------------------------------------------------------------
  FUNCTION COL_LIST(
      par_table_name VARCHAR2)
    RETURN VARCHAR2;
  --------------------------------------------------------------------------------
  FUNCTION IS_BOOLEAN_COLUMN(
      par_table_name  VARCHAR2,
      par_column_name VARCHAR2)
    RETURN BOOLEAN;
  --------------------------------------------------------------------------------
  FUNCTION GET_TABLE_PREFIX(
      PAR_TABLE_NAME VARCHAR2)
    RETURN VARCHAR2;
  --------------------------------------------------------------------------------
  function PAR_NAME_WO_IDENTIFIER(PAR_PAR_NAME varchar2) return varchar2;
  --------------------------------------------------------------------------------
  /** Function returns true if the column has LOV type constraint.
  *
  *
  */
  FUNCTION IS_LOV_COLUMN(
      par_table_name  VARCHAR2,
      par_column_name VARCHAR2)
    RETURN BOOLEAN;
    
  END code_synth_helpers;

/
