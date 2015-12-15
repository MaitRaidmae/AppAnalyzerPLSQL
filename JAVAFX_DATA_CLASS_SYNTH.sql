--------------------------------------------------------
--  DDL for Package JAVAFX_DATA_CLASS_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."JAVAFX_DATA_CLASS_SYNTH" 
IS
  ------------------------------------------------------------------------------
  PROCEDURE DATA_CLASS(
      PAR_TABLE_NAME       varchar2,
    PAR_PARENT_CODE_NAME varchar2 default '',
    par_view_only boolean default false); -- Generates java class for the table data
  ------------------------------------------------------------------------------
  FUNCTION DATA_CONSTRUCTOR(
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates the constructor for the class
  ------------------------------------------------------------------------------
  FUNCTION GETTER(
      par_par_name   VARCHAR2,
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates getter functions
  ------------------------------------------------------------------------------
  FUNCTION SETTER(
      par_par_name   VARCHAR2,
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates setter functions
  ------------------------------------------------------------------------------
  FUNCTION COMMIT_FUNCTION(
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates the commmit function for the data object
  ------------------------------------------------------------------------------
  /**
  *   Returns the constructor by parent key (i.e. creates java instance from
  *   the foreign key reference (this has to be one-to-one relationship for now).
  */
  FUNCTION PARENT_CONSTRUCTOR(
      PAR_TABLE_NAME       VARCHAR2,
      PAR_PARENT_CODE_NAME VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  FUNCTION CALL_STATEMENT(
      PAR_TABLE_NAME VARCHAR2)
    RETURN VARCHAR2;

  /**
  *   Returns the getResultSet function for the data class (i.e. function that returns
  *   a cursor with specified table row for current table.
  */
  FUNCTION GET_RESULT_SET(
      PAR_TABLE_NAME       VARCHAR2,
      par_parent_code_name VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  /**
  *   Generates a function that initiates the edit window generation
  *
  *
  */
  FUNCTION SHOW_EDIT_DIALOG(
      par_table_name VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  FUNCTION GET_GRID(
     par_table_name VARCHAR2
  ) return varchar2;
  ------------------------------------------------------------------------------
  function SET_FROM_GRID(par_table_name varchar2
  ) return varchar2;
  
END javafx_data_class_synth;

/
