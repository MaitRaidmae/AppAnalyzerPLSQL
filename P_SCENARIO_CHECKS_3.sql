--------------------------------------------------------
--  DDL for Package Body P_SCENARIO_CHECKS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."P_SCENARIO_CHECKS" IS
-----------------------------------------------------------------------------
PROCEDURE UPDATE_ROW(
PAR_SCC_CODE NUMBER,
PAR_SCC_APL_CODE NUMBER,
PAR_SCC_VALUE VARCHAR2,
PAR_SCC_SRN_CODE VARCHAR2,
PAR_SCC_CHK_CODE NUMBER)
IS

BEGIN
UPDATE B_SCENARIO_CHECKS
SET 
SCC_APL_CODE = PAR_SCC_APL_CODE,
SCC_VALUE = PAR_SCC_VALUE,
SCC_SRN_CODE = PAR_SCC_SRN_CODE,
SCC_CHK_CODE = PAR_SCC_CHK_CODE
WHERE SCC_CODE = PAR_SCC_CODE;
END UPDATE_ROW;
-----------------------------------------------------------------------------

PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER,
PAR_RESULTS OUT SYS_REFCURSOR)
IS

LC_SELECT VARCHAR2(2000);

BEGIN
LC_SELECT := ' SELECT * FROM B_SCENARIO_CHECKS WHERE '||par_field_name||' = :KEY';
OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;

END GET_ROWS;
-----------------------------------------------------------------------------

PROCEDURE UPDATE_ROW_NVALUE(par_code NUMBER, par_column VARCHAR2, par_value NUMBER)
IS
BEGIN
EXECUTE IMMEDIATE
'UPDATE B_SCENARIO_CHECKS
set '||PAR_COLUMN||' = :value
where SCC_code = :code' using par_value, par_code;
END UPDATE_ROW_NVALUE;
-----------------------------------------------------------------------------

PROCEDURE UPDATE_ROW_NVALUE(par_code NUMBER, par_column VARCHAR2, par_value VARCHAR2)
IS
BEGIN
EXECUTE IMMEDIATE
'UPDATE B_SCENARIO_CHECKS
set '||PAR_COLUMN||' = :value
where SCC_code = :code' using par_value, par_code;
END UPDATE_ROW_NVALUE;
-----------------------------------------------------------------------------

PROCEDURE GET_RESULTS_PAGE(par_page_nr IN NUMBER, par_results_per_page IN NUMBER,
result_set OUT SYS_REFCURSOR, par_find_by_field VARCHAR2 DEFAULT NULL,
par_find_by_value NUMBER DEFAULT NULL)
IS
ln_first_row    PLS_INTEGER;
ln_last_row     PLS_INTEGER;
lc_sql          VARCHAR2(2000);
BEGIN
ln_first_row := par_page_nr * par_results_per_page - (par_results_per_page - 1);
ln_last_row := par_page_nr * par_results_per_page;
if (par_find_by_field is null) then
lc_sql :='select scc_code,scc_apl_code,scc_value,scc_srn_code,scc_chk_code
FROM ( SELECT /*+ FIRST_ROWS(n) */
tbl.*, ROWNUM rnum
from ( select * from B_SCENARIO_CHECKS ) tbl
where ROWNUM <=
'||ln_last_row||' )
WHERE RNUM  >= '||LN_FIRST_ROW;
ELSE
lc_sql := 'select scc_code,scc_apl_code,scc_value,scc_srn_code,scc_chk_code
FROM ( SELECT /*+ FIRST_ROWS(n) */
tbl.*, ROWNUM rnum
from ( select * from B_SCENARIO_CHECKS where '||par_find_by_field||'='||par_find_by_value||') tbl
where ROWNUM <=
'||ln_last_row||' )
WHERE RNUM  >= '||LN_FIRST_ROW;
end if;
OPEN RESULT_SET FOR lc_sql;
end GET_RESULTS_PAGE;
-----------------------------------------------------------------------------

PROCEDURE INSERT_ROW(
par_scc_apl_code NUMBER,
par_scc_value VARCHAR2,
par_scc_srn_code VARCHAR2,
par_scc_chk_code NUMBER
)
IS
BEGIN
INSERT
INTO B_SCENARIO_CHECKS
(
scc_apl_code,scc_value,scc_srn_code,scc_chk_code
)
VALUES
(
par_scc_apl_code, par_scc_value, par_scc_srn_code, par_scc_chk_code
);
END INSERT_ROW;
-----------------------------------------------------------------------------

PROCEDURE DELETE_ROW(par_code NUMBER)
IS
BEGIN
DELETE FROM B_SCENARIO_CHECKS WHERE scc_code = par_code;
END DELETE_ROW;
-----------------------------------------------------------------------------
END P_SCENARIO_CHECKS;

/
