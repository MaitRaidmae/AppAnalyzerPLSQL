--------------------------------------------------------
--  DDL for Package Body CHECKS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."CHECKS" 
IS

PROCEDURE RUN_CHECKS(
    par_chs_code b_check_Suits.chs_code%type,
    par_comment varchar2)
IS

  CURSOR cApps
  IS
    SELECT apl_code FROM b_applications;
  rApps cApps%rowType;

  rindex      pls_INTEGER;
  slno        pls_INTEGER;
  totalwork   pls_INTEGER;
  sofar       pls_INTEGER;
  obj         pls_INTEGER;


  ln_srn_code b_suit_runs.srn_code%type;

BEGIN
  -- Register suit run
  INSERT
  INTO b_suit_runs VALUES
    (
      NULL,
      par_chs_code,
      systimestamp,
      par_comment
    )
  RETURNING srn_code
  INTO ln_srn_code;
  --Set up progress tracking on session longops
  rindex := dbms_application_info.set_session_longops_nohint;
  sofar  := 0;
  -- Get total number of applications
  select count(1) into totalwork from b_applications;
  
  FOR rApps IN cApps
  LOOP
    RUN_APPLICATION_CHECKS
    (
      rApps.apl_code, par_chs_code, ln_srn_code
    );
    sofar := sofar + 1;
    dbms_application_info.set_session_longops(rindex, slno,
            'Running Checks', obj, 0, sofar, totalwork, 'application', 'applications');
  END LOOP;

END RUN_CHECKS;
--------------------------------------------------------------------------------
PROCEDURE RUN_APPLICATION_CHECKS(
    PAR_APL_CODE B_APPLICATIONS.APL_CODE%TYPE,
    PAR_CHS_CODE B_CHECK_SUITS.CHS_CODE%TYPE,
    PAR_SRN_CODE B_SUIT_RUNS.SRN_CODE%TYPE)
IS

  CURSOR cChecks
  IS
    SELECT chk_mnemo FROM b_checks WHERE chk_active = 1 and chk_chs_code = par_chs_code;
  rChecks cChecks%rowtype;

BEGIN
  FOR rChecks IN cChecks
    LOOP
      checks.run_check(par_apl_code, rChecks.chk_mnemo, par_chs_code, par_srn_code);
    END LOOP;
    
END RUN_APPLICATION_CHECKS;
--------------------------------------------------------------------------------
PROCEDURE RUN_CHECK(
    par_apl_code b_applications.APL_CODE%TYPE,
    par_chk_mnemo B_CHECKS.CHK_MNEMO%TYPE,
    PAR_CHS_CODE B_CHECK_SUITS.CHS_CODE%TYPE,
    par_srn_code b_suit_Runs.srn_code%type)
IS

  lc_chk_type     VARCHAR2(20);
  lc_chk_field    VARCHAR2(50);
  lb_check_result BOOLEAN;
  ln_check_result INTEGER;
  lr_check_row b_checks%rowtype;
  lr_rpredict_row B_RPREDICT_CHECK_PARS%ROWTYPE;

BEGIN
  -- Get the information regarding the check:
  EXECUTE IMMEDIATE 'select * from b_checks where chk_mnemo = :1 and chk_chs_code = :2' INTO lr_check_row USING par_chk_mnemo, par_chs_code;

  IF (lr_check_row.chk_type    = 'MIN' OR lr_check_row.chk_type = 'MAX') THEN
    lb_check_result           := MINMAX_CHECK(par_apl_code, lr_check_row.chk_code, lr_check_row.chk_type);
  ELSIF (lr_check_row.chk_type = 'RPREDICT') THEN

    SELECT *
    INTO lr_rpredict_row
    FROM b_rpredict_check_pars
    WHERE rcp_chk_code = lr_check_row.chk_code;

    lb_check_result   := R_PREDICT(par_apl_code, lr_rpredict_row.rcp_model, lr_rpredict_row.rcp_type, lr_rpredict_row.rcp_threshold);
    -- Add other logics for stuff here.
    NULL;
  END IF;

  IF (lb_check_result = TRUE) THEN
    ln_check_result  := 1;
  ELSE
    ln_check_result := 0;
  END IF;

  INSERT
  INTO b_app_checks VALUES
    (
      NULL,
      par_apl_code,
      lr_check_row.chk_code,
      ln_check_result,
      par_srn_code
    );

END RUN_CHECK;
------------------------------------------------------------------------------
FUNCTION MINMAX_CHECK
  (
    par_apl_code b_applications.apl_code%TYPE,
    par_chk_code b_checks.chk_code%TYPE,
    par_type     b_checks.chk_type%type
  )
  RETURN BOOLEAN
IS

  ln_apl_value NUMBER;
  lr_minmax_pars b_minmax_check_pars%rowtype;
  BEGIN
    select * into lr_minmax_pars from b_minmax_check_pars  where mcp_chk_code = par_chk_code;
    -- Get the value from the application
    EXECUTE IMMEDIATE 'select ' || lr_minmax_pars.mcp_check_field || ' from b_applications where apl_code = :1' INTO ln_apl_value USING par_apl_code;

    -- Return True of false based on the which type check is executed.
    IF (par_type = 'MIN' AND ln_apl_value < lr_minmax_pars.mcp_threshold) THEN
      RETURN TRUE;
    ELSIF (par_type = 'MAX' AND ln_apl_value > lr_minmax_pars.mcp_threshold) THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END MINMAX_CHECK;
--------------------------------------------------------------------------------
FUNCTION R_PREDICT(
    par_apl_code   b_applications.apl_code%TYPE,
    par_model_name rqsys.rq$datastore.dsname%TYPE,
    par_check_type b_rpredict_check_pars.rcp_type%type,
    par_threshold  NUMBER)
  RETURN BOOLEAN
IS

lc_script_name     VARCHAR2(2000) := 'PredictRow';
ln_predicted_value NUMBER;

BEGIN
  ln_predicted_value := RINTERFACE.PREDICT_VALUE(par_model_name, lc_script_name, 'select * from b_applications where apl_code = '||par_apl_code);

  IF (par_check_type = 'MAX' AND ln_predicted_value > par_threshold) THEN
    RETURN TRUE;
  ELSIF (par_check_type = 'MIN' AND ln_predicted_value < par_threshold) THEN
    RETURN true;
  ELSE
    RETURN FALSE;
  END IF;
END R_PREDICT;

--------------------------------------------------------------------------------
END;

/
