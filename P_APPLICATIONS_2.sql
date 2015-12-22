--------------------------------------------------------
--  DDL for Package P_APPLICATIONS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."P_APPLICATIONS" 
IS

TYPE gc_applications
IS
  REF
  CURSOR
    RETURN b_applications%rowtype;

    PROCEDURE APPLICATION_DATA_INSERT(
        par_record b_applications%rowtype);

    PROCEDURE GET_RESULTS_PAGE(
        par_page_nr          IN NUMBER,
        PAR_RESULTS_PER_PAGE IN NUMBER,
        result_set OUT sys_refcursor,
        PAR_FIND_BY_FIELD VARCHAR2 DEFAULT NULL, 
        par_find_by_value number default null);

    PROCEDURE GET_ROWS(
        PAR_FIELD_NAME IN VARCHAR2,
        PAR_KEY        IN NUMBER,
        PAR_RESULTS OUT SYS_REFCURSOR);

  END P_APPLICATIONS;

/
