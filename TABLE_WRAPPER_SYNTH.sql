--------------------------------------------------------
--  DDL for Package TABLE_WRAPPER_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."TABLE_WRAPPER_SYNTH" 
IS

  PROCEDURE GENERATE_TABLE_PACKAGE(
      PAR_TABLE_NAME VARCHAR2);
  ------------------------------------------------------------------------------
  FUNCTION GEN_UPDATE_ROW(
      par_table_name VARCHAR2,
      par_type       VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  FUNCTION GEN_GET_ROWS(
      PAR_TABLE_NAME VARCHAR2,
      par_type       VARCHAR2 )
    RETURN VARCHAR2;

END TABLE_WRAPPER_SYNTH;

/
