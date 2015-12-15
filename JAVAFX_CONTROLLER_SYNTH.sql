--------------------------------------------------------
--  DDL for Package JAVAFX_CONTROLLER_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."JAVAFX_CONTROLLER_SYNTH" 
IS

cursor cControllerChildren(p_controller varchar2) is
(select * from b_app_children where ach_aco_code = (select aco_code from b_app_controllers where aco_controller = p_controller));
------------------------------------------------------------------------------
  PROCEDURE CONTROLLER_CLASS(
      par_controller   varchar2,
      par_display_type VARCHAR2 DEFAULT 'table'); --Generate code for view controller
  ------------------------------------------------------------------------------
  FUNCTION SEARCH_DATA(
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generate GetData method for controller
  ------------------------------------------------------------------------------
  FUNCTION CONTROLLER_EDIT_HANDLERS(
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates EditHandlers
  ------------------------------------------------------------------------------
  FUNCTION CHECK_BOX_FACTORY(
      par_table_name VARCHAR2)
    RETURN VARCHAR2; -- Generates cell factory for booleans
  ------------------------------------------------------------------------------
  FUNCTION SHOW_RESULTS(
      PAR_CONTROLLER   VARCHAR2,
      PAR_DISPLAY_TYPE VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  FUNCTION SET_STAGE
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  function INIT_OBJECT(par_controller varchar2)
  return varchar2;
  ------------------------------------------------------------------------------
END JAVAFX_CONTROLLER_SYNTH;

/
