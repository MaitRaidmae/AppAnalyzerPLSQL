--------------------------------------------------------
--  DDL for Package MISC_UTILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."MISC_UTILS" 
AS

type GT_LOV_VC2
IS
  TABLE OF VARCHAR2(100);
  ------------------------------------------------------------------------------
  FUNCTION CONSTRAINT_LOV(
      par_owner      VARCHAR2,
      par_table_name VARCHAR2,
      par_field_name VARCHAR2)
    RETURN GT_LOV_VC2 PIPELINED;
  ------------------------------------------------------------------------------
  PROCEDURE GENERATE_PRETTY_NAMES(
      par_table_name VARCHAR2);
  ------------------------------------------------------------------------------
  FUNCTION PRETTY_NAME  (
    PAR_TABLE_NAME  VARCHAR2,
    PAR_COLUMN_NAME VARCHAR2
  )
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  PROCEDURE TABLE_COLS(par_table_name IN VARCHAR2, par_results out SYS_REFCURSOR);
  ------------------------------------------------------------------------------
  PROCEDURE TABLE_COL_LOV(par_owner VARCHAR2,
      par_table_name VARCHAR2,
      par_field_name VARCHAR2,
      par_constraint1 VARCHAR2 DEFAULT NULL,
      par_constraint2 VARCHAR2 DEFAULT NULL,
      par_constraint3 VARCHAR2 DEFAULT NULL,
      par_results out  SYS_REFCURSOR);
  ------------------------------------------------------------------------------
  FUNCTION TEST_FUN RETURN VARCHAR2;
END MISC_UTILS;

/
