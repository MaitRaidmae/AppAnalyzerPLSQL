--------------------------------------------------------
--  DDL for Package CHECKS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HUNDISILM"."CHECKS" 
IS
  /**
  *   Runs all Checks that are active for all applications
  */
  PROCEDURE RUN_CHECKS(par_chs_code b_check_Suits.chs_code%type,
  par_comment varchar2);
  ------------------------------------------------------------------------------
  /**
  *   Runs all Checks that are active for an application.
  *   # par_apl_code -> unique code for the application
  */
  PROCEDURE RUN_APPLICATION_CHECKS(
      PAR_APL_CODE B_APPLICATIONS.APL_CODE%TYPE,
      PAR_CHS_CODE B_CHECK_SUITS.CHS_CODE%TYPE,
      PAR_SRN_CODE B_SUIT_RUNS.SRN_CODE%TYPE);
  ------------------------------------------------------------------------------
  /**
  *   Runs a check for a given application:
  *   # par_apl_code   -> unique code for the application
  *   # par_chk_mnemo  -> mnemo for the check to run
  */
  PROCEDURE RUN_CHECK(
      par_apl_code B_APPLICATIONS.APL_CODE%TYPE,
      PAR_CHK_MNEMO B_CHECKS.CHK_MNEMO%TYPE,
      PAR_CHS_CODE  B_CHECK_SUITS.CHS_CODE%TYPE,
      par_srn_code  b_suit_runs.srn_code%type);
  ------------------------------------------------------------------------------
  /**
  *   Returns true if the checked minimum or maximum value is below/above the
  *   value indicated in the chk_value parameter
  *   otherwise returns false.
  */
  FUNCTION MINMAX_CHECK(
      par_apl_code b_applications.apl_code%TYPE,
      par_chk_code b_checks.chk_code%TYPE,
      par_type     b_checks.chk_type%TYPE)
    RETURN BOOLEAN;
  ------------------------------------------------------------------------------
  /**
  *   Runs an R model predict function and returns true or false based on 
  *   whether the predicted value is over/under the given threshold value.
  */
  FUNCTION R_PREDICT(
    par_apl_code   b_applications.apl_code%TYPE,
    par_model_name rqsys.rq$datastore.dsname%TYPE,
    par_check_type b_rpredict_check_pars.rcp_type%type,
    par_threshold  NUMBER)
  RETURN BOOLEAN;

END;

/
