--------------------------------------------------------
--  DDL for Package Body MISC_UTILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."MISC_UTILS" 
AS

FUNCTION CONSTRAINT_LOV(
    par_owner      VARCHAR2,
    par_table_name VARCHAR2,
    par_field_name VARCHAR2)
  RETURN gt_lov_vc2 pipelined
AS

  lc_search_condition VARCHAR2(2000);
  li_start_index PLS_INTEGER := 1;
  li_end_index pls_integer   := 1;
  li_index PLS_INTEGER       := 1;
  lct_collection gt_lov_vc2  := gt_lov_vc2();
  dbg pls_integer            := 0;

BEGIN

  SELECT search_condition
  INTO lc_search_condition
  FROM all_constraints
  WHERE owner = par_owner
  AND constraint_name LIKE '%'||par_table_name||'%'
  AND constraint_name LIKE '%'||par_field_name||'%';

  LOOP
    li_start_index := instr(lc_search_condition, '=''', li_end_index) + 2;
    li_end_index   := instr(lc_search_condition, '''', li_start_index);
    EXIT
  WHEN li_start_index = 2;

    lct_collection.EXTEND;
    lct_collection(lct_collection.count) := SUBSTR(lc_search_condition, li_start_index, li_end_index-li_start_index);
    li_start_index                       := li_end_index;
    pipe ROW(lct_collection(lct_collection.count));
    dbg := dbg + 1;
    EXIT
  WHEN dbg > 10;
  END LOOP;
  RETURN;

END CONSTRAINT_LOV;
-------------------------------------------------------------------------------
PROCEDURE GENERATE_PRETTY_NAMES(
    par_table_name VARCHAR2)
IS

  CURSOR cPrettyRow(p_table_name VARCHAR2, p_column_name VARCHAR2)
  IS
    SELECT *
    FROM b_pretty_names
    WHERE prn_table_name = p_table_name
    AND prn_column_name  = p_column_name;
  rPrettyRow cPrettyRow%Rowtype;

  lc_pretty_name VARCHAR2(2000);

BEGIN

  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP

    OPEN cPrettyRow(rTabCols.table_name, rTabCols.column_name);
    FETCH cPrettyRow INTO rPrettyRow;
    IF CPRETTYROW%NOTFOUND THEN
      LC_PRETTY_NAME := SUBSTR(RTABCOLS.COLUMN_NAME, INSTR(RTABCOLS.COLUMN_NAME, '_', 1)+1, 99999);
      LC_PRETTY_NAME := REPLACE(INITCAP(LC_PRETTY_NAME), '_', ' ');
      INSERT
      INTO b_pretty_names
        (
          prn_table_name,
          prn_column_name,
          prn_pretty_name
        )
        VALUES
        (
          rTabCols.table_name,
          rTabCols.column_name,
          lc_pretty_name
        );
    END IF;
    CLOSE cPrettyRow;
  END LOOP;

END GENERATE_PRETTY_NAMES;
--------------------------------------------------------------------------------
  FUNCTION PRETTY_NAME(
      PAR_TABLE_NAME  VARCHAR2,
      PAR_COLUMN_NAME VARCHAR2)
    RETURN VARCHAR2 is
    
    lc_pretty_name varchar2(2000);
    
    BEGIN
    
      SELECT PRN_PRETTY_NAME into lc_pretty_name FROM B_PRETTY_NAMES WHERE PRN_TABLE_NAME = PAR_TABLE_NAME
      AND PRN_COLUMN_NAME = PAR_COLUMN_NAME;
      
    RETURN LC_PRETTY_NAME;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN 'Error, could not find '|| par_Table_name||'.'||par_column_name;
    
    end PRETTY_NAME;


END MISC_UTILS;

/
