--------------------------------------------------------
--  DDL for Package JAVAFX_CONTROLLER_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."JAVAFX_CONTROLLER_SYNTH" AUTHID DEFINER
IS

  CURSOR cControllerChildren(p_controller VARCHAR2)
  IS
    (SELECT *
    FROM b_controller_siblings
    WHERE cos_aco_code =
      (SELECT aco_code
      FROM b_app_controllers
      WHERE aco_controller = p_controller
      AND cos_type = 'CHILD'
      )
    );
    ------------------------------------------------------------------------------
    PROCEDURE CONTROLLER_CLASS(
        par_controller VARCHAR2) ; --Generate code for view controller
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
        par_table_name VARCHAR2,
        par_parameter  VARCHAR2)
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
    FUNCTION INIT_OBJECT(
        par_controller VARCHAR2)
      RETURN VARCHAR2;
    ------------------------------------------------------------------------------
    FUNCTION SET_PARENT(
        par_table_name VARCHAR2)
      RETURN VARCHAR2;

  END JAVAFX_CONTROLLER_SYNTH;

/
