--------------------------------------------------------
--  DDL for Package Body JAVAFX_DATA_CLASS_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."JAVAFX_DATA_CLASS_SYNTH" 
IS

  --------------------------------------------------------------------------------
  -- Local private helper functions ----------------------------------------------
  --------------------------------------------------------------------------------

FUNCTION CALL_STATEMENT(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);
  li_i pls_integer := 0;
  lc_pars VARCHAR2(32000);

BEGIN


  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    li_i    :=li_i+1;
    lc_pars := lc_pars || 'callStmt.set'||
    CASE csh.gr_par_type_map(rTabCols.column_name)
    WHEN 'Integer' THEN
      'Int'
    ELSE
      csh.gr_par_type_map(rTabCols.column_name)
    END|| '('||li_i||', this.get'||csh.snake_to_camel(rTabCols.column_name)||'());'||CHR(10);
  END LOOP;

  --cut the last newline from lc_pars
  lc_pars := SUBSTR(lc_pars, 1, LENGTH(lc_pars)-1);

  lc_out  := 'try(CallableStatement callStmt = db_connection.prepareCall("{ call '||REPLACE(upper(par_table_name), 'B_', 'P_')||'.UPDATE_ROW('||rpad('?', 2*li_i-1, ',?')||') }")) {';
  add_ln(lc_out, lc_pars);

  add_ln(lc_out, 'callStmt.execute();');
  RETURN lc_out;

END;
--------------------------------------------------------------------------------
FUNCTION EDIT_GRID_CASE_BLOCK(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);

BEGIN

  FOR rTabCols IN csh.cTabCols(par_Table_name)
  LOOP
    add_ln(lc_out, 'case "'||rTabCols.column_name||'":');
    if (CSH.IS_LOV_COLUMN(PAR_TABLE_NAME, RTABCOLS.COLUMN_NAME) = true) then
      add_ln(lc_out, 'comboBox = new ComboBox(SQLExecutor.getLov("'||par_table_name||'",metaData.getColumnName(i)));');
      add_ln(lc_out, 'comboBox.setValue(dataValues.getString(i));');
      add_ln(lc_out, 'fieldType = "comboBox";');
    ELSE
      add_ln(lc_out, 'textField = new TextField(dataValues.getString(i));');
      add_ln(lc_out, 'fieldType = "textField";');
    END IF;
    add_ln(lc_out, 'break;');
  END LOOP;
  RETURN lc_out;
END;
--------------------------------------------------------------------------------
FUNCTION SET_FROM_GRID_CASE_BLOCK(
    par_Table_name VARCHAR2,
    par_type       VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);

BEGIN

  csh.MAP_PARS(par_table_name);
  FOR rTabCols IN csh.cTabCols(par_Table_name)
  LOOP
    IF (CSH.IS_LOV_COLUMN(PAR_TABLE_NAME, RTABCOLS.COLUMN_NAME) = FALSE AND PAR_TYPE = 'TextField') THEN

      ADD_LN(LC_OUT, 'case "'||RTABCOLS.COLUMN_NAME||'":');
      CASE (CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME))
      WHEN 'Integer' THEN
        ADD_LN(LC_OUT, 'this.set'||csh.SNAKE_TO_CAMEL(rTabCols.column_name)||'(Integer.parseInt(textField.getText()));');
      WHEN 'Double' THEN
        ADD_LN(LC_OUT, 'this.set'||csh.SNAKE_TO_CAMEL(rTabCols.column_name)||'(Double.parseDouble(textField.getText()));');
      WHEN 'String' THEN
        ADD_LN(LC_OUT, 'this.set'||CSH.SNAKE_TO_CAMEL(RTABCOLS.COLUMN_NAME)||'(textField.getText());');
      ELSE 
        ADD_LN(LC_OUT, 'Nuuks');
      END CASE;
      ADD_LN(LC_OUT, 'break;');
    ELSIF (CSH.IS_LOV_COLUMN(PAR_TABLE_NAME, RTABCOLS.COLUMN_NAME) = TRUE AND par_type = 'ComboBox') THEN
      ADD_LN(LC_OUT, 'case "'||RTABCOLS.COLUMN_NAME||'":');
      CASE (CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME))
      WHEN 'Integer' THEN
        ADD_LN(LC_OUT, 'this.set'||csh.SNAKE_TO_CAMEL(rTabCols.column_name)||'((Integer) comboBox.getValue());');
      WHEN 'Double' THEN
        add_ln(lc_out, 'this.set'||csh.SNAKE_TO_CAMEL(rTabCols.column_name)||'((Double) comboBox.getValue());');
      WHEN 'String' THEN
        ADD_LN(LC_OUT, 'this.set'||CSH.SNAKE_TO_CAMEL(RTABCOLS.COLUMN_NAME)||'((String) comboBox.getValue());');
      END CASE;
      ADD_LN(LC_OUT, 'break;');
    END IF;

  END LOOP;

  RETURN LC_OUT;
END SET_FROM_GRID_CASE_BLOCK;
--------------------------------------------------------------------------------
------- Published functions ----------------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE DATA_CLASS(
    PAR_TABLE_NAME       varchar2,
    PAR_PARENT_CODE_NAME varchar2 default '',
    par_view_only boolean default false)
IS
  lc_table_name VARCHAR2(100);
  lc_buffer     VARCHAR2(32000):= '';

BEGIN

  -- Map parameters:
  CSH.MAP_PARS(par_table_name);
  -- convert input to lowercase
  lc_table_name := lower(par_table_name);
  -- Generate header imports etc
  lc_buffer := 'import java.io.IOException;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.SimpleDoubleProperty;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Insets;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import javafx.stage.Window;
' ;
  doutln(lc_buffer);
  lc_table_name := csh.CAMEL_TABLENAME_WOB(lc_table_name);
  -- Generate class declaration
  doutln('public class ' ||lc_table_name|| '{');

  -- Generate general properties
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    CASE CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)
    WHEN 'Date' THEN
      DOUTLN('private final SimpleObjectProperty<Date> '||LOWER(RTABCOLS.COLUMN_NAME)||';');
    else
      DOUTLN('private final Simple'||CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)||'Property '||LOWER(RTABCOLS.COLUMN_NAME)||';');
    end case;
  END LOOP;
  doutln('');
  -- Add constructor to the class
  doutln(DATA_CONSTRUCTOR(par_table_name));

  -- Add parent constructor if parent code is indicated:
  IF (par_parent_code_name IS NOT NULL) THEN
    DOUTLN(PARENT_CONSTRUCTOR(par_table_name, par_parent_code_name));
  END IF;

  --Generate getters and setters
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    doutln(GETTER(rTabCols.column_name, par_table_name));
    if (par_view_only = FALSE) then
      DOUTLN(SETTER(RTABCOLS.COLUMN_NAME, PAR_TABLE_NAME));
    end if;
  end LOOP;
 
  -- Add getEditGrid function
    doutln(get_grid(par_table_name));
    
  if (par_view_only = FALSE) then
    --Add Commit function
    DOUTLN(COMMIT_FUNCTION(PAR_TABLE_NAME));
    -- Add showEditDialog function
    doutln(SHOW_EDIT_DIALOG(par_table_name));
    -- Add setEditGrid function
    DOUTLN(SET_FROM_GRID(PAR_TABLE_NAME));
  end if;
  
  --Add getResultSet function (only when parent code is indicated for now)
  IF (PAR_PARENT_CODE_NAME IS NOT NULL) THEN
    DOUTLN(GET_RESULT_SET(PAR_TABLE_NAME, PAR_PARENT_CODE_NAME));
  END IF;
  
  -- Add closing bracket
  DOUTLN('}');
   
END DATA_CLASS;
--------------------------------------------------------------------------------
FUNCTION DATA_CONSTRUCTOR(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_table_name VARCHAR2(100);
  lc_buffer     VARCHAR2(32000):= '';
  lc_parameters VARCHAR2(32000):= '';
  lc_out        VARCHAR2(32000):= '';

BEGIN
  lc_table_name := csh.CAMEL_TABLENAME_WOB(par_table_name);

  -- Map pars just in case
  csh.MAP_PARS(par_table_name);
  -- Generate parameters list
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    -- Generate pars
    lc_parameters := lc_parameters ||csh.gr_par_type_map(rTabCols.column_name)||' '||lower(rTabCols.column_name)||','||CHR(10);
  END LOOP;

  -- Cut last coma and newline
  lc_parameters := SUBSTR(lc_parameters, 1, LENGTH(lc_parameters)-2);

  -- Generate constructor
  add_ln(lc_out, 'public ' ||lc_table_name|| '('|| lc_parameters||'){');
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
  CASE CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)
  WHEN 'Date' then
    ADD_LN(LC_OUT, 'this.'||LOWER(RTABCOLS.COLUMN_NAME)|| ' = new SimpleObjectProperty('||LOWER(RTABCOLS.COLUMN_NAME)||');');
  else
    ADD_LN(LC_OUT, 'this.'||LOWER(RTABCOLS.COLUMN_NAME)|| ' = new Simple'||CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)||'Property('||LOWER(RTABCOLS.COLUMN_NAME)||');');
  end case;
  END LOOP;

  add_ln(lc_out, '}');

  RETURN LC_OUT;

END DATA_CONSTRUCTOR;
--------------------------------------------------------------------------------
FUNCTION GETTER(
    par_par_name   VARCHAR2,
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);

BEGIN
  -- Generate getter function
  add_ln(lc_out, 'public '||csh.gr_par_type_map(par_par_name)||' get'||csh.SNAKE_TO_CAMEL(par_par_name)||'() {');
  add_ln(lc_out, 'return '||lower(par_par_name)||'.get();');
  add_ln(lc_out, '}');
  RETURN lc_out;
END GETTER;
--------------------------------------------------------------------------------
FUNCTION SETTER(
    par_par_name   VARCHAR2,
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_local_name   VARCHAR2(50) := lower(SUBSTR(par_par_name, instr(par_par_name, '_', 1)   +1, 99));
  lc_table_prefix VARCHAR2(10) := lower(SUBSTR(par_par_name, 1, instr(par_par_name, '_', 1)-1));
  lc_out          VARCHAR2(32000);
BEGIN

  add_ln(lc_out, 'public void set'||csh.SNAKE_TO_CAMEL(par_par_name)||'('||csh.gr_par_type_map(par_par_name)||' '||lc_local_name||') {');
  add_ln(lc_out, lower(par_par_name)||'.set('||lc_local_name||');');
  -- If it's a boolean column assume it's a checkbox and update directly.
  if (csh.IS_BOOLEAN_COLUMN(par_table_name,par_par_name) = TRUE) then
    add_ln(lc_out, 'SQLExecutor.updateRowNvalue("'||replace(par_table_name,'B_','P_')||'",getChkCode(),"'||par_par_name||'",get'||csh.SNAKE_TO_CAMEL(par_par_name)||'());');
  end if;
  add_ln(lc_out, '}');

  RETURN lc_out;
END SETTER;
--------------------------------------------------------------------------------
FUNCTION COMMIT_FUNCTION(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  LC_OUT VARCHAR2(32000);

BEGIN

  add_ln(lc_out, 'public void commit() {');
  add_ln(lc_out, 'Connection db_connection = ConnectionManager.cl_conn;');
  add_ln(lc_out, CALL_STATEMENT(par_table_name));
  add_ln(lc_out, '} catch (SQLException sqle) {');
  add_ln(lc_out, 'Alerts.AlertSQL(sqle);');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');

  RETURN LC_OUT;

END COMMIT_FUNCTION;
--------------------------------------------------------------------------------
FUNCTION PARENT_CONSTRUCTOR(
    par_table_name       VARCHAR2,
    par_parent_code_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out        VARCHAR2(32000);
  lc_table_name VARCHAR2(2000);
  lc_parameters VARCHAR2(2000);

BEGIN

  lc_table_name := CSH.CAMEL_TABLENAME_WOB(par_table_name);
  -- Map pars just in case
  csh.MAP_PARS(par_table_name);

  -- Generate pars
  lc_parameters := '(Integer '||par_parent_code_name||')';

  -- Generate constructor
  ADD_LN(LC_OUT, 'public ' ||LC_TABLE_NAME||LC_PARAMETERS||'{');
  ADD_LN(LC_OUT, 'CallableStatementResults callResults = SQLExecutor.getTableRow("'||REPLACE(UPPER(PAR_TABLE_NAME), 'B_', 'P_')|| '", "'||CSH.GET_TABLE_PREFIX(PAR_TABLE_NAME)||upper(PAR_PARENT_CODE_NAME)||'", '||PAR_PARENT_CODE_NAME||');');
  ADD_LN(LC_OUT, 'ResultSet pars = callResults.getResultSet();');
  -- Generate the not initialized workaround pars.
  FOR RTABCOLS IN CSH.CTABCOLS(PAR_TABLE_NAME)
  LOOP
    IF (LOWER(csh.PAR_NAME_WO_IDENTIFIER(rTabCols.column_name)) != lower(par_parent_code_name)) THEN
      ADD_LN(LC_OUT, CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME) ||' '||LOWER(csh.PAR_NAME_WO_IDENTIFIER(rTabCols.column_name))|| ' = '||
      CASE CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)
      WHEN 'Integer' THEN
        '0'
      WHEN 'Double' THEN
        '0.0'
      WHEN 'String' THEN
        '""'
      END ||';');
    END IF;
  END LOOP;
  -- Generate the try block
  ADD_LN(LC_OUT, 'try {');
  ADD_LN(LC_OUT, 'pars.next();');
  -- Loop Here
  FOR RTABCOLS IN CSH.CTABCOLS(PAR_TABLE_NAME)
  LOOP
    ADD_LN(LC_OUT, LOWER(CSH.PAR_NAME_WO_IDENTIFIER(RTABCOLS.COLUMN_NAME))||' = pars.get'||
    CASE CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)
    WHEN 'Integer' THEN
      'Int'
    ELSE
      CSH.GR_PAR_TYPE_MAP(RTABCOLS.COLUMN_NAME)
    END || '('||csh.cTabCols%rowcount||');');
  END LOOP;

  ADD_LN(LC_OUT, '} catch (SQLException sqle) {');
  ADD_LN(LC_OUT, 'Alerts.AlertSQL(sqle);');
  ADD_LN(LC_OUT, '}');
  ADD_LN(LC_OUT, 'callResults.close();');
  -- Generate the initalizers
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    add_ln(lc_out, 'this.'||lower(rTabCols.column_name)|| ' = new Simple'||csh.gr_par_type_map(rTabCols.column_name)||'Property('||LOWER(csh.PAR_NAME_WO_IDENTIFIER(rTabCols.column_name))||');');
  END LOOP;
  add_ln(lc_out, '}');

  RETURN LC_OUT;

END PARENT_CONSTRUCTOR;
--------------------------------------------------------------------------------

FUNCTION GET_RESULT_SET(
    PAR_TABLE_NAME       VARCHAR2,
    par_parent_code_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);
BEGIN
  CSH.MAP_PARS(PAR_TABLE_NAME);

  ADD_LN(LC_OUT, 'public static CallableStatementResults getResultSet(Integer '||par_parent_code_name||') {');
  ADD_LN(LC_OUT, 'CallableStatementResults callResults = SQLExecutor.getTableRow("'||REPLACE(UPPER(PAR_TABLE_NAME), 'B_', 'P_')|| '", "'||CSH.GET_TABLE_PREFIX(PAR_TABLE_NAME)||upper(PAR_PARENT_CODE_NAME)||'", '||PAR_PARENT_CODE_NAME||');');
  ADD_LN(LC_OUT, 'return callResults;');
  ADD_LN(LC_OUT, '}');

  RETURN lc_out;
END GET_RESULT_SET;
--------------------------------------------------------------------------------
FUNCTION SHOW_EDIT_DIALOG(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);

BEGIN
  lc_out:='public boolean showEditDialog(Window owner) {';
  add_ln(lc_out, 'try {');
  add_ln(lc_out, '//Load Edit FXML');
  add_ln(lc_out, 'FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/applicationanalyzer/FXML/Edit'||CSH.CAMEL_TABLENAME_WOB(par_table_name)||'.fxml"));');
  add_ln(lc_out, 'AnchorPane page = (AnchorPane) fxmlLoader.load();');
  add_ln(lc_out, '//Load edit Stage');
  add_ln(lc_out, 'Stage editStage = new Stage();');
  add_ln(lc_out, 'editStage.setTitle("<<<PUT TITLE HERE>>>");');
  add_ln(lc_out, 'editStage.initModality(Modality.WINDOW_MODAL);');
  add_ln(lc_out, 'editStage.initOwner(owner);');
  add_ln(lc_out, 'Scene scene = new Scene(page);');
  add_ln(lc_out, 'editStage.setScene(scene);');
  add_ln(lc_out, '// Set data object into the contoller');
  ADD_LN(LC_OUT, 'EditCheckController controller = fxmlLoader.getController();');
  add_ln(lc_out, 'controller.initObject(this);');
  add_ln(lc_out, 'controller.setStage(editStage);');
  add_ln(lc_out, 'editStage.showAndWait();');

  add_ln(lc_out, 'return controller.isCommited();');
  add_ln(lc_out, '} catch (IOException e) {');
  add_ln(lc_out, 'Alerts.AlertIO(e);');
  add_ln(lc_out, 'return false;');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');

  RETURN lc_out;
END SHOW_EDIT_DIALOG;
--------------------------------------------------------------------------------

FUNCTION GET_GRID(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS
  lc_table_name varchar2(32000) := csh.CAMEL_TABLENAME_WOB(par_table_name);
  lc_out VARCHAR2(32000);
BEGIN
  lc_out :='public GridPane getGrid(Boolean editable) {';
  add_ln(lc_out, 'GridPane grid = new GridPane();');
  add_ln(lc_out, 'int k = 0;');
  add_ln(lc_out, 'String fieldType = "";');
  add_ln(lc_out, 'CallableStatementResults callResults = SQLExecutor.getTableRow("'||REPLACE(par_table_name, 'B_', 'P_')||'", "'||csh.get_table_prefix(par_Table_name) ||'_CODE", this.get'||initcap(csh.get_table_prefix(par_Table_name))||'Code());');
  add_ln(lc_out, 'ResultSet dataValues = callResults.getResultSet();');
  add_ln(lc_out, 'ResultSetMetaData metaData;');
  add_ln(lc_out, 'TextField textField = new TextField();');
  add_ln(lc_out, 'ComboBox comboBox  = new ComboBox();');
  
  add_ln(lc_out, 'try {');
  add_ln(lc_out, 'metaData = dataValues.getMetaData();');
  add_ln(lc_out, 'dataValues.next();');
  add_ln(lc_out, 'for (int i = 2; i <= metaData.getColumnCount(); i++) {');
  add_ln(lc_out, 'Label fieldNameLbl = new Label(SQLExecutor.getPrettyName("'||par_table_name||'", metaData.getColumnName(i)));');
  add_ln(lc_out, 'grid.add(fieldNameLbl, 0, k);');
  add_ln(lc_out, 'if (!editable) {');
  add_ln(lc_out, 'Label fieldValueLbl = new Label(dataValues.getString(i));');
  add_ln(lc_out, 'grid.add(fieldValueLbl, 1, k);');
  add_ln(lc_out, '} else {');
  add_ln(lc_out, 'switch (metaData.getColumnName(i)) {');
  add_ln(lc_out, EDIT_GRID_CASE_BLOCK(par_table_name));
  add_ln(lc_out, '}');
  add_ln(lc_out, 'switch (fieldType) {');
  add_ln(lc_out, 'case "textField":');
  add_ln(lc_out, 'textField.setId(metaData.getColumnName(i));');
  add_ln(lc_out, 'grid.add(textField, 1, k);');
  add_ln(lc_out, 'break;');
  add_ln(lc_out, 'case "comboBox":');
  add_ln(lc_out, 'comboBox.setId(metaData.getColumnName(i));');
  add_ln(lc_out, 'grid.add(comboBox, 1, k);');
  add_ln(lc_out, 'break;');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  add_ln(lc_out, 'k++;');
  add_ln(lc_out, '}');
  add_ln(lc_out, '} catch (SQLException sqle) {');
  add_ln(lc_out, 'Alerts.AlertSQL(sqle);');
  add_ln(lc_out, '}');
  add_ln(lc_out, 'callResults.close();');
  add_ln(lc_out, 'return grid;');
  add_ln(lc_out, '}');
  RETURN lc_out;
END;
--------------------------------------------------------------------------------
FUNCTION SET_FROM_GRID(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);
BEGIN
  add_ln(lc_out, 'public void setFromGrid(GridPane grid) {');
  add_ln(lc_out, 'for (Node node : grid.getChildren()) {');
  add_ln(lc_out, 'if (node instanceof TextField) {');
  add_ln(lc_out, 'TextField textField = (TextField) node;');
  ADD_LN(LC_OUT, 'switch (textField.getId()) {');
  ADD_LN(LC_OUT, SET_FROM_GRID_CASE_BLOCK(PAR_TABLE_NAME, 'TextField'));
  add_ln(lc_out, '}');
  add_ln(lc_out, '} else if (node instanceof ComboBox) {');
  add_ln(lc_out, 'ComboBox comboBox = (ComboBox) node;');
  ADD_LN(LC_OUT, 'switch (comboBox.getId()) {');
  add_ln(lc_out, SET_FROM_GRID_CASE_BLOCK(par_table_name, 'ComboBox'));
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  RETURN lc_out;
end SET_FROM_GRID;
--------------------------------------------------------------------------------

end JAVAFX_DATA_CLASS_SYNTH;

/
