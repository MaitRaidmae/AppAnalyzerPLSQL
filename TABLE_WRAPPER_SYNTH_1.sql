--------------------------------------------------------
--  DDL for Package Body TABLE_WRAPPER_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."TABLE_WRAPPER_SYNTH" 
IS

FUNCTION IS_PRIMARY_KEY(
    par_owner       VARCHAR2,
    par_table_name  VARCHAR2,
    par_column_name VARCHAR2)
  RETURN BOOLEAN
IS

  CURSOR cColConstraints
  IS
    SELECT *
    FROM all_cons_columns
    WHERE table_name = par_table_name
    AND column_name  = par_column_name
    AND owner        = par_owner;
  rColConstraints cColConstraints%rowtype;

  lb_return   BOOLEAN := false;
  lc_con_name VARCHAR2(2000);

BEGIN
  --check column has constraint on it:
  FOR rColConstraints IN cColConstraints
  LOOP
    SELECT constraint_type
    INTO lc_con_name
    FROM all_constraints
    WHERE constraint_name=rColConstraints.constraint_name;

    IF (lc_con_name      = 'P') THEN
      lb_return         := true;
    END IF;

  END LOOP;

  RETURN lb_return;

END IS_PRIMARY_KEY;
--------------------------------------------------------------------------------
function GEN_UPDATE_PARS(par_table_name varchar2) return varchar2 is

lc_out varchar2(32000);
lc_primary_key varchar2(2000);
begin
lc_out := 'SET ';
for rTabCols in csh.cTabCols(par_table_name)
loop
if (is_primary_key('HUNDISILM',par_table_name,rTabCols.column_name) = TRUE) then
  lc_primary_key:=rTabCols.column_name;
else 
  
  add_ln(lc_out,rTabCols.column_name||' = PAR_'||rTabCols.column_name||',');
end if;
end loop;

--Remove last coma
lc_out := SUBSTR(lc_out, 1, LENGTH(lc_out)-1);

ADD_LN(LC_OUT,'WHERE '||lc_primary_key||' = PAR_'||lc_primary_key||';');
RETURN LC_OUT;
end GEN_UPDATE_PARS;
--------------------------------------------------------------------------------
PROCEDURE GENERATE_TABLE_PACKAGE(PAR_TABLE_NAME VARCHAR2) IS

LC_SQL VARCHAR2(32000);
LC_PACKAGE_NAME varchar2(2000);
lc_line varchar2(1000);

BEGIN 

IF (UPPER(SUBSTR(PAR_TABLE_NAME,1,2)) = 'B_') THEN
 LC_PACKAGE_NAME := regexp_replace(UPPER(PAR_TABLE_NAME),'B_','P_',1,1);
ELSE
 LC_PACKAGE_NAME := regexp_replace(UPPER(PAR_TABLE_NAME),'V_','P_',1,1);
END IF;

LC_LINE:='-----------------------------------------------------------------------------';
LC_SQL := 'CREATE OR REPLACE PACKAGE '||LC_PACKAGE_NAME|| ' IS';
ADD_LN(LC_SQL,LC_LINE);
add_ln(lc_sql,GEN_UPDATE_ROW(PAR_TABLE_NAME,'HEADER'));
ADD_LN(LC_SQL,LC_LINE);
add_ln(lc_sql,GEN_GET_ROWS(PAR_TABLE_NAME,'HEADER'));
ADD_LN(LC_SQL,LC_LINE);
ADD_LN(LC_SQL,'END ' ||LC_PACKAGE_NAME||';');
ADD_LN(LC_SQL,'/');
add_ln(lc_sql,'CREATE OR REPLACE PACKAGE BODY '||LC_PACKAGE_NAME ||' IS');
ADD_LN(LC_SQL,LC_LINE);
ADD_LN(LC_SQL,GEN_UPDATE_ROW(PAR_TABLE_NAME,'BODY'));
ADD_LN(LC_SQL,LC_LINE);
ADD_LN(LC_SQL,GEN_GET_ROWS(PAR_TABLE_NAME,'BODY'));
ADD_LN(LC_SQL,LC_LINE);
ADD_LN(LC_SQL,'END ' ||LC_PACKAGE_NAME||';');

DOUTLN(LC_SQL);

end GENERATE_TABLE_PACKAGE;
--------------------------------------------------------------------------------
FUNCTION GEN_UPDATE_ROW(
    par_table_name VARCHAR2,
    par_type       VARCHAR2)
  RETURN VARCHAR2
IS

lc_out varchar2(32000);
lc_out_header varchar2(2000);
lc_parameters varchar2(2000);

BEGIN
  -- Map pars just in case
  csh.MAP_PARS(par_table_name);
  
  -- Generate parameters list
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    -- Generate pars
    lc_parameters := lc_parameters ||'PAR_'||rTabCols.column_name||' '||rTabCols.data_type||','||CHR(10);
  END LOOP;
  
  -- Cut last coma and newline and add closing bracket
  lc_parameters := SUBSTR(lc_parameters, 1, LENGTH(lc_parameters)-2)||')';

LC_OUT:='PROCEDURE UPDATE_ROW(';
add_ln(lc_out,lc_parameters);
-- Return declaration if in header mode.
if (par_type = 'HEADER') then
  lc_out := lc_out||';';
  return lc_out;
end if;
--Generate body
add_ln(lc_out,'IS');
add_ln(lc_out,'');
add_ln(lc_out,'BEGIN');
add_ln(lc_out,'UPDATE '||par_table_name);
add_ln(lc_out,GEN_UPDATE_PARS(par_table_name));
add_ln(lc_out,'END UPDATE_ROW;');

  RETURN LC_OUT;
  
end GEN_UPDATE_ROW;
--------------------------------------------------------------------------------
FUNCTION GEN_GET_ROWS(
    PAR_TABLE_NAME varchar2,
    par_type varchar2
    )
  RETURN VARCHAR2
is

lc_out varchar2(32000);

begin
  
  ADD_LN(LC_OUT,'PROCEDURE GET_ROWS(PAR_FIELD_NAME IN VARCHAR2, PAR_KEY IN NUMBER,');
  ADD_LN(LC_OUT,'PAR_RESULTS OUT SYS_REFCURSOR)');
  if (PAR_TYPE = 'HEADER') then
    LC_OUT := LC_OUT || ';';
    return lc_out;
  end if;
  ADD_LN(LC_OUT,'IS');
  ADD_LN(LC_OUT,'');
  ADD_LN(LC_OUT,'LC_SELECT VARCHAR2(2000);');
  ADD_LN(LC_OUT,'');
  ADD_LN(LC_OUT,'BEGIN');
  ADD_LN(LC_OUT,'LC_SELECT := '' SELECT * FROM '||par_table_name||' WHERE ''||par_field_name||'' = :KEY'';');
  ADD_LN(LC_OUT,'OPEN PAR_RESULTS FOR LC_SELECT USING PAR_KEY;');
  ADD_LN(LC_OUT,'');
  add_ln(lc_out,'END GET_ROWS;');
    
  RETURN lc_out;
end GEN_GET_ROWS;
--------------------------------------------------------------------------------
-- TODO: Add update_row_nvalue and update_row_cvalue functions

END TABLE_WRAPPER_SYNTH;

/
