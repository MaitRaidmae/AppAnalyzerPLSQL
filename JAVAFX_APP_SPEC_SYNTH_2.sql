--------------------------------------------------------
--  DDL for Package JAVAFX_APP_SPEC_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."JAVAFX_APP_SPEC_SYNTH" AS 
  /**
  *   This loads app specific handlers according to table_name. If two apps in 
  *   the far future have same tablename but different functions, this needs to
  *   be improved.
  */
  FUNCTION MOUSE_EVENT_HANDLER(
      PAR_CONTROLLER VARCHAR2)
    RETURN VARCHAR2;
  ------------------------------------------------------------------------------
  FUNCTION CUSTOM_CODE(
    PAR_CONTROLLER VARCHAR2)
  RETURN VARCHAR2;
  ------------------------------------------------------------------------------
END JAVAFX_APP_SPEC_SYNTH;

/
