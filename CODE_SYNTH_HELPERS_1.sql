--------------------------------------------------------
--  DDL for Package Body CODE_SYNTH_HELPERS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."CODE_SYNTH_HELPERS" is
--------------------------------------------------------------------------------
PROCEDURE MAP_PARS(
    par_table_name VARCHAR2)
IS

BEGIN
  FOR rTabCols IN cTabCols(par_table_name)
  LOOP
    -- Generate properties
    IF (rTabCols.data_type                   = 'NUMBER' AND rTabCols.data_scale = 0) THEN
      gr_par_type_map(rTabCols.column_name) := 'Integer';
    ELSIF (rTabCols.data_type                = 'NUMBER') THEN
      gr_par_type_map(rTabCols.column_name) := 'Double';
    ELSIF (rTabCols.data_type                = 'VARCHAR2' OR rTabCols.data_type = 'CHAR') THEN
      gr_par_type_map(rTabCols.column_name) := 'String';
    ELSIF (rTabCols.data_type                = 'TIMESTAMP(6)') THEN
      gr_par_type_map(rTabCols.column_name) := 'Date';
    END IF;
  END LOOP;
END;
--------------------------------------------------------------------------------
FUNCTION SNAKE_TO_CAMEL(par_string VARCHAR2, par_lower_init boolean default false) RETURN VARCHAR2
IS

lc_out varchar2(2000);
BEGIN
  lc_out := REPLACE(initcap(par_string), '_', '');
  if (par_lower_init = true) then
    lc_out:= lower(substr(lc_out,1,1))||substr(lc_out,2,9999999);
  end if;
  return lc_out;
END;
--------------------------------------------------------------------------------
FUNCTION COL_TAG(
    par_fxid VARCHAR2,
    par_text VARCHAR2)
  RETURN xmltype
IS

  lc_tag VARCHAR2(2000);

BEGIN
  lc_tag :='<TableColumn';
  lc_tag :=lc_tag || ' fx:id="'||par_fxid||'"';
  lc_tag :=lc_tag || ' text="'||par_text||'"';
  lc_tag := lc_tag || ' />';

  RETURN xmltype(lc_tag);

END;
--------------------------------------------------------------------------------
PROCEDURE ADD_LN(
    par_clob    IN OUT CLOB,
    par_string2 IN VARCHAR2)
IS

BEGIN
  par_clob:=par_clob||CHR(10)||par_string2;
END;
--------------------------------------------------------------------------------
FUNCTION CAMEL_TABLENAME_WOB(
    par_table_name VARCHAR2,
    par_lower_init boolean default false)
  RETURN VARCHAR2
IS

  lc_table_name VARCHAR2(100) := lower(par_table_name);
BEGIN
  -- Remove b_ or v_ from table_name
  lc_table_name := regexp_replace(lc_table_name, 'b_', '', 1, 1);
  lc_table_name := regexp_replace(lc_table_name, 'v_', '', 1, 1);
  
  -- initcap and remove _ thingies
  lc_table_name := REPLACE(initcap(lc_table_name), '_', '');
  
  if (par_lower_init = true) then
    lc_table_name:= lower(substr(lc_table_name,1,1))||substr(lc_table_name,2,9999999);
  end if;

  RETURN lc_table_name;
END;
--------------------------------------------------------------------------------
FUNCTION TABLE_PAR_LIST(
    par_table_name    VARCHAR2,
    par_variable_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_parameters VARCHAR2(2000);
  li_i PLS_INTEGER := 0;

BEGIN

  MAP_PARS(par_table_name);
  lc_parameters := '(';
  FOR rTabCols IN cTabCols(par_table_name)
  LOOP
    li_i:=li_i+1;
    -- Generate pars
    lc_parameters := lc_parameters ||par_variable_name||'.get'||
    CASE gr_par_type_map(rTabCols.column_name)
    WHEN 'Integer' THEN
      'Int'
    ELSE
      gr_par_type_map(rTabCols.column_name)
    END||'('||li_i||')'||','||CHR(10);
  END LOOP;

  -- Cut last coma and newline
  lc_parameters := SUBSTR(lc_parameters, 1, LENGTH(lc_parameters)-2)||')';

  RETURN lc_parameters;
END;
--------------------------------------------------------------------------------
FUNCTION COL_LIST(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(2000);

BEGIN
  FOR rTabCols IN cTabCols(par_table_name)
  LOOP
    lc_out:=lc_out||lower(rTabCols.column_name)||',';
  END LOOP;
  RETURN SUBSTR(lc_out, 1, LENGTH(lc_out)-1);
END;
--------------------------------------------------------------------------------
FUNCTION IS_BOOLEAN_COLUMN(
    par_table_name  VARCHAR2,
    par_column_name VARCHAR2) return BOOLEAN
IS

lc_owner varchar2(2000);

BEGIN
 EXECUTE IMMEDIATE 'SELECT owner FROM user_constraints WHERE table_name = '''||par_table_name||''' AND
constraint_name like ''%'||par_column_name||'_BOOLEAN%''' into lc_owner;
 IF (LENGTH(lc_owner) > 0) THEN
    RETURN TRUE;
 ELSE 
    RETURN FALSE;
 END IF;
 
 exception WHEN no_data_found THEN
   return false;
 
END IS_BOOLEAN_COLUMN;
--------------------------------------------------------------------------------
FUNCTION GET_TABLE_PREFIX(PAR_TABLE_NAME VARCHAR2) RETURN VARCHAR2 IS

lc_col_name varchar2(2000);

BEGIN

select column_name into lc_col_name from user_tab_cols where table_name = par_Table_name and rownum = 1;

return substr(lc_col_name,1,instr(lc_col_name,'_',1)-1);

END GET_TABLE_PREFIX;
--------------------------------------------------------------------------------
function PAR_NAME_WO_IDENTIFIER(PAR_PAR_NAME varchar2) return varchar2 is

lc_out varchar2(2000);

begin

lc_out := substr(par_par_name,instr(par_par_name,'_',1)+1,999);

return lc_out;
end PAR_NAME_WO_IDENTIFIER;
--------------------------------------------------------------------------------
FUNCTION IS_LOV_COLUMN(
    par_table_name  VARCHAR2,
    par_column_name VARCHAR2)
  RETURN BOOLEAN
AS
  lc_owner VARCHAR2(2000);


BEGIN
  EXECUTE IMMEDIATE 'SELECT owner FROM user_constraints WHERE table_name = '''||par_table_name||''' AND    
constraint_name like ''%'||par_column_name||'#LOV''' INTO lc_owner;
  IF (LENGTH(lc_owner) > 0) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;

EXCEPTION
WHEN no_data_found THEN
  RETURN false;
END IS_LOV_COLUMN;


end code_synth_helpers;

/
