--------------------------------------------------------
--  DDL for Package Body SCENARIO_RUNNER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."SCENARIO_RUNNER" 
AS

FUNCTION GET_PAR_VALUE(
    par_table_name  VARCHAR2,
    par_column_name VARCHAR2,
    par_data_type   VARCHAR2,
    par_chk_code    NUMBER)
  RETURN VARCHAR2
IS

  lc_out  VARCHAR2(2000) ;
  ln_out  NUMBER;
  lts_out TIMESTAMP;
  ld_out  DATE;
  lc_sql  VARCHAR2(2000) ;

BEGIN

  lc_sql := 'select '||par_column_name||' from '||par_table_name||' where '||csh.get_table_prefix(par_table_name) ||'_chk_code = :par_chk_code';
  DOUTLN(PAR_COLUMN_NAME) ;
  DOUTLN(PAR_TABLE_NAME) ;
  DOUTLN('MEH'||par_chk_code) ;
  CASE(par_data_type)
  WHEN 'VARCHAR2' THEN
    EXECUTE immediate lc_sql INTO lc_out USING par_chk_code;
  WHEN 'NUMBER' THEN
    EXECUTE immediate lc_sql INTO ln_out USING par_chk_code;
    lc_out := TO_CHAR(ln_out) ;
  WHEN 'TIMESTAMP(6)' THEN
    EXECUTE immediate lc_sql INTO lts_out USING par_chk_code;
    lc_out := TO_CHAR(ln_out) ;
  WHEN 'DATE' THEN
    EXECUTE immediate lc_sql INTO ld_out USING par_chk_code;
    lc_out := TO_CHAR(ln_out) ;
  ELSE
    EXECUTE immediate 'select to_char('||par_column_name||') from '||par_table_name||' where '||csh.get_table_prefix(par_table_name) ||
    '_chk_code = :par_chk_code' INTO lc_out USING par_chk_code;
  END CASE;

  RETURN LC_OUT;

END GET_PAR_VALUE;

------------------------------------------------------------------------------
PROCEDURE RUN_SCENARIO(
    par_scenario_code NUMBER)
AS
BEGIN
  -- TODO: Implementation required for PROCEDURE SCENARIO_RUNNER.RUN_SCENARIO
  NULL;
END RUN_SCENARIO;
------------------------------------------------------------------------------
PROCEDURE REGISTER_CHECK_PARS(
    par_scenario_code b_suite_scenarios.ssc_code%type,
    par_run_code b_suit_runs.srn_code%type,
    par_run_type b_scenario_check_pars.scp_type%type)
IS

  CURSOR cChecks(p_suite_code NUMBER)
  IS
    SELECT * FROM b_checks WHERE chk_chs_code = p_suite_code AND chk_active = 1;
  rChecks cChecks%rowtype;

  lc_table     VARCHAR2(200) ;
  lc_par_value VARCHAR2(2000) ;
  ln_chs_code b_check_suits.chs_code%type;
  lc_prefix    varchar2(100);

BEGIN

  SELECT ssc_chs_code
  INTO ln_chs_code
  FROM b_suite_scenarios
  WHERE ssc_code = par_scenario_code;

  doutln(ln_chs_code) ;
  FOR rChecks IN cChecks(ln_chs_code)
  LOOP
    lc_table :=
    CASE rChecks.chk_type
    WHEN 'MAX' THEN
      'B_MINMAX_CHECK_PARS'
    WHEN 'MIN' THEN
      'B_MINMAX_CHECK_PARS'
    WHEN 'RPREDICT' THEN
      'B_RPREDICT_CHECK_PARS'
    WHEN 'ALLOWED_LOV' THEN
      'B_LOV_CHECK_PARS'
    WHEN 'FORBIDDEN_LOV' THEN
      'B_LOV_CHECK_PARS'
    END;

    FOR rTabCols IN csh.cTabCols(lc_table)
    LOOP
      lc_prefix := upper(csh.get_table_prefix(lc_table));
      -- Skip primary and foreign key columns
      IF(rTabCols.column_name != lc_prefix||'_CODE' AND rTabCols.column_name != lc_prefix||'_CHK_CODE') THEN
      lc_par_value := GET_PAR_VALUE(lc_table, rTabCols.column_name, rTabCols.data_type, rChecks.chk_code) ;

      P_SCENARIO_CHECK_PARS.INSERT_ROW(par_scp_chk_mnemo => rChecks.chk_mnemo, par_scp_chk_type => rChecks.chk_type, par_scp_par_name =>
      rTabCols.column_name, par_scp_par_value => lc_par_value, par_scp_srn_code => par_run_code, par_scp_ssc_code => par_scenario_code, par_scp_type
      => par_run_type) ;
    END IF;
  END LOOP;
END LOOP;

END;

END SCENARIO_RUNNER;

/
