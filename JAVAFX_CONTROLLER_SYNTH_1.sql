--------------------------------------------------------
--  DDL for Package Body JAVAFX_CONTROLLER_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."JAVAFX_CONTROLLER_SYNTH" 
IS

  --------------------------------------------------------------------------------
  -------------- PRIVATE MEHTODS -------------------------------------------------
  --------------------------------------------------------------------------------

FUNCTION PARENT_TABLE(
    par_controller VARCHAR2)
  RETURN VARCHAR2
IS

  lc_table VARCHAR2(2000);

BEGIN

  SELECT aco_table
  INTO lc_table
  FROM b_app_controllers
  WHERE aco_controller = par_controller;

  RETURN lc_table;

END PARENT_TABLE;
--------------------------------------------------------------------------------
FUNCTION COL_LIST(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(2000);

BEGIN
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    lc_out:=lc_out||lower(rTabCols.column_name)||',';
  END LOOP;
  RETURN SUBSTR(lc_out, 1, LENGTH(lc_out)-1);
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

  csh.MAP_PARS(par_table_name);
  lc_parameters := '(';
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    li_i:=li_i+1;
    -- Generate pars
    lc_parameters := lc_parameters ||par_variable_name||'.get'||
    CASE csh.gr_par_type_map(rTabCols.column_name)
    WHEN 'Integer' THEN
      'Int'
    ELSE
      csh.gr_par_type_map(rTabCols.column_name)
    END||'('||li_i||')'||','||CHR(10);
  END LOOP;

  -- Cut last coma and newline
  lc_parameters := SUBSTR(lc_parameters, 1, LENGTH(lc_parameters)-2)||')';

  RETURN lc_parameters;
END;
--------------------------------------------------------------------------------
FUNCTION DEFAULT_DOUBLECLICK_HANDLER(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out       VARCHAR2(32000) := '';
  lc_tablename VARCHAR2(2000)  := csh.CAMEL_TABLENAME_WOB(par_table_name);

BEGIN

  add_ln(lc_out, 'private EventHandler<MouseEvent> MouseEventHandler(TableRow<'||lc_tablename||'> row) {');
  add_ln(lc_out, 'EventHandler<MouseEvent> doubleClick');
  add_ln(lc_out, '= new EventHandler<MouseEvent>() {');
  add_ln(lc_out, '@Override');
  add_ln(lc_out, 'public void handle(final MouseEvent doubleClick) {');
  add_ln(lc_out, 'if (doubleClick.getClickCount() >= 2) {');
  add_ln(lc_out, '//Add Setting dataSTore element here EXAMPLE: ');
  add_ln(lc_out, '//dataStore.setCurrentSuite(row.getItem().getChsCode());');
  add_ln(lc_out, 'try {');
  add_ln(lc_out, 'FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource(<<<<ADD_RESOURCE_HERE>>>>>);');
  add_ln(lc_out, 'Parent root1 = (Parent) fxmlLoader.load();');
  add_ln(lc_out, 'Stage stage = new Stage();');
  add_ln(lc_out, 'stage.setScene(new Scene(root1));');
  add_ln(lc_out, 'stage.setTitle("<<<<SET_TITLE>>>>>");');
  add_ln(lc_out, 'stage.getIcons().add(new Image("/applicationanalyzer/icon.png"));');
  add_ln(lc_out, 'stage.show();');
  add_ln(lc_out, '} catch (Exception e) {');
  add_ln(lc_out, 'Alerts.GeneralAlert(e);');

  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  add_ln(lc_out, '}');
  add_ln(lc_out, '};');
  add_ln(lc_out, 'RETURN doubleClick;');
  add_ln(lc_out, '}');

  RETURN lc_out;

END DEFAULT_DOUBLECLICK_HANDLER;
--------------------------------------------------------------------------------
FUNCTION TABLE_VIEW(
    PAR_TABLE_NAME VARCHAR2)
  RETURN VARCHAR2
IS

  LC_OUT          VARCHAR2(32000);
  lc_table_name   VARCHAR2(2000) := csh.CAMEL_TABLENAME_WOB(par_table_name);
  LC_INSTANCE     VARCHAR2(2000) := CSH.CAMEL_TABLENAME_WOB(PAR_TABLE_NAME, TRUE);
  LC_FACTORY      VARCHAR2(32000);
  lc_package      varchar2(2000);
BEGIN
  IF (SUBSTR(UPPER(PAR_TABLE_NAME),1,2) = 'B_') THEN
    LC_PACKAGE := REGEXP_REPLACE(UPPER(PAR_TABLE_NAME), 'B_', 'P_', 1, 1);
  ELSE
    lc_package := REGEXP_REPLACE(UPPER(PAR_TABLE_NAME), 'V_', 'P_', 1, 1);
  end if;
  ADD_LN(LC_OUT, 'ObservableList<'||CSH.CAMEL_TABLENAME_WOB(PAR_TABLE_NAME)||'> obsArrayList = FXCollections.observableArrayList();');
  add_ln(lc_out, 'CallableStatementResults callResults = SQLExecutor.getTablePage("'||lc_package||'", 1, results);');
  ADD_LN(LC_OUT, 'ResultSet query_results = callResults.getResultSet();');
  ADD_LN(LC_OUT, 'TableView<'||LC_TABLE_NAME||'> '||LC_INSTANCE||'Table = new TableView();');
  -- Add column declarations;
  FOR rTabCols IN CSH.cTabCols(PAR_TABLE_NAME)
    LOOP
      add_ln(lc_out, 'TableColumn '|| lower(rTabCols.column_name)||' = new TableColumn();');
    END LOOP;
    
  ADD_LN(LC_OUT, lc_instance||'Table.getColumns().setAll('||COL_LIST(par_table_name)||');');
  add_ln(lc_out, 'try {');
  add_ln(lc_out, 'while (query_results.next()) {');
  add_ln(lc_out, lc_table_name||' dataInstance = new '||lc_table_name||TABLE_PAR_LIST(par_table_name, 'query_results')||';');
  add_ln(lc_out, 'obsArrayList.add(dataInstance);');
  add_ln(lc_out, '}');

  -- This has some code remaining from editable Tables version - leaving it in for now;
  FOR rTabCols IN csh.cTabCols(par_table_name)
  LOOP
    IF (csh.gr_par_type_map(rTabCols.column_name)                    != 'String') THEN
      IF (csh.IS_BOOLEAN_COLUMN(par_table_name, rTabCols.column_name) = TRUE) THEN
        lc_factory                                                   := 'new CheckBoxCellFactory()';
      ELSE
        lc_factory := 'TextFieldTableCell.forTableColumn(new StringToDecimal("'||csh.gr_par_type_map(rTabCols.column_name)||'"))';
      END IF;
    END IF;
    add_ln(lc_out, lower(rTabCols.column_name)||'.setCellValueFactory(new PropertyValueFactory<>("'||csh.SNAKE_TO_CAMEL(rTabCols.column_name)||'"));');
    IF (csh.IS_BOOLEAN_COLUMN(par_table_name, rTabCols.column_name) = TRUE) THEN
      add_ln(lc_out, lower(rTabCols.column_name)||'.setCellFactory('||lc_factory||');');
    END IF;
    lc_factory := 'TextFieldTableCell.forTableColumn()';
  END LOOP;
  -- Add tableRowFactory for the doubleClick Thingy (this has a bit of a problem though).

  add_ln(lc_out, lc_instance||'Table.setRowFactory(rowfactory -> {');
  add_ln(lc_out, '              TableRow<'||lc_table_name||'> row = new TableRow<>();');
  add_ln(lc_out, '            row.setOnMouseClicked(MouseEventHandler(row));');
  add_ln(lc_out, '              return row;');
  add_ln(lc_out, '          });  ');
  add_ln(lc_out, lc_instance||'Table.setItems(obsArrayList);');
  add_ln(lc_out, lc_instance||'Table.getColumns().setAll('||COL_LIST(par_table_name)||');');
  add_ln(lc_out, '}');

  add_ln(lc_out, 'catch (SQLException sqle){');
  add_ln(lc_out, 'Alerts.AlertSQL(sqle);');
  add_ln(lc_out, '}');
  -- Close the statement
  add_ln(lc_out, 'callResults.close();');
  RETURN lc_out;
END TABLE_VIEW;
--------------------------------------------------------------------------------
FUNCTION GRID_VIEW(
    PAR_TABLE_NAME VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);
BEGIN

  add_ln(lc_out, 'GridPane apps_grid = applications.getGrid(false);');
  add_ln(lc_out, 'ApplicationsPane.getChildren().add(apps_grid);');

  RETURN lc_out;
END GRID_VIEW;

--------------------------------------------------------------------------------
-------------- PUBLIC MEHTODS --------------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE CONTROLLER_CLASS(
    par_controller   VARCHAR2,
    par_display_type VARCHAR2 DEFAULT 'table')
IS

  LC_TABLE          VARCHAR2(100) := PARENT_TABLE(PAR_CONTROLLER);
  lc_table_name     VARCHAR2(100) := CSH.CAMEL_TABLENAME_WOB(lc_table);
  LC_INSTANCE       VARCHAR2(100) := CSH.CAMEL_TABLENAME_WOB(LC_TABLE, TRUE);
  LR_APP_CONTROLLER B_APP_CONTROLLERS%ROWTYPE;
  LC_CHILD_INSTANCE VARCHAR2(1000);
  LC_CLASS          VARCHAR2(1000);
  
  cursor cAppController is
  select * from b_app_controllers where aco_controller=par_controller;  
  rAppController cAppController%rowtype;
  
BEGIN
  -- Generate import list
  doutln('import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.geometry.Pos;

');

  open cAppController;
  fetch cAppController into rAppController;
  close cAppController;
  
  -- Generate class header
  doutln('public class '||CSH.CAMEL_TABLENAME_WOB(par_controller)||'Controller implements Initializable {');


  
  DOUTLN('@FXML');
  DOUTLN('private AnchorPane '||csh.CAMEL_TABLENAME_WOB(par_controller, false)||';');
  doutln('@FXML');
  DOUTLN('private AnchorPane '||LC_INSTANCE||'Pane;');
  
    -- Generate FXML parameters
  if (upper(rAppController.aco_view_type) = 'TABLE') then
    doutln('@FXML');
    DOUTLN('private TableView '||LC_INSTANCE||'Table;');
  end if;
  
  FOR rChildren IN cControllerChildren(upper(par_controller))
  LOOP
    doutln('@FXML');
    DOUTLN('private AnchorPane '||csh.CAMEL_TABLENAME_WOB(rChildren.ach_table, true)||'Pane;');
  END LOOP;
  
  -- Add Parent table_column declarations
  -- TODO This is a bit messed up - consider moving whole table generation to code based instead of XML;
  IF (upper(rAppController.aco_view_type) = 'TABLE') then
    FOR rTabCols IN CSH.cTabCols(lc_table)
    LOOP
      doutln('@FXML');
      doutln('private TableColumn '|| lower(rTabCols.column_name)||';');
    END LOOP;
  END IF;
  
  -- Add object declarations
  DOUTLN(LC_TABLE_NAME||' '||LC_INSTANCE||';');
  FOR rChildren IN cControllerChildren(upper(par_controller))
  LOOP
    LC_CHILD_INSTANCE := CSH.CAMEL_TABLENAME_WOB(RCHILDREN.ACH_TABLE, TRUE);
    LC_CLASS := CSH.CAMEL_TABLENAME_WOB(RCHILDREN.ACH_TABLE, FALSE);
    DOUTLN(lc_class||' '||lc_child_instance||';');
  END LOOP;
  doutln('Stage stage;');
  
  
  -- TODO: Move this to the initializer - Search button can just call initializer.
  /* TODO: Disregard previeous TODO - this is a stupid plan.
  Move this stuff to separate function and call it where you need to
  (buttons, initializers and stuff).
  */
  -- TODO: PS. Do the previous TODO.
  doutln('');
  doutln(SEARCH_DATA(lc_table));
  doutln('');

  DOUTLN('');
  doutln(SHOW_RESULTS(par_controller, rAppController.aco_view_type));
  doutln('');

  -- Generate ValueHandlers
  doutln('');
  doutln(CONTROLLER_EDIT_HANDLERS(lc_table));
  doutln('');

  doutln('@Override
public void initialize(URL url, ResourceBundle rb){}');

  -- Add Default MouseEventHandler for DoubleClickable TableRows
  doutln(JAVAFX_APP_SPEC_SYNTH.MOUSE_EVENT_HANDLER(par_controller));

  -- Add Cell Factory for CheckBoxes
  doutln(CHECK_BOX_FACTORY(lc_table));

  -- Add setStage function
  doutln(SET_STAGE);

  -- Add initObject function
  doutln(INIT_OBJECT(par_controller));

  -- Add closing bracket for class body
  doutln('}');

END CONTROLLER_CLASS;
--------------------------------------------------------------------------------

FUNCTION SEARCH_DATA(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
AS
  lc_out VARCHAR2(32000);
BEGIN

  add_ln(lc_out, '@FXML');
  add_ln(lc_out, 'public void searchData(ActionEvent event) {');
  add_ln(lc_out, 'showResults(pageNr);');
  add_ln(lc_out, '}');

  RETURN lc_out;
END SEARCH_DATA;
--------------------------------------------------------------------------------
FUNCTION CONTROLLER_EDIT_HANDLERS(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
AS
BEGIN
  -- TODO: Implementation required for FUNCTION JAVAFX_CONTROLLER_SYNTH.CONTROLLER_EDIT_HANDLERS
  RETURN NULL;
END CONTROLLER_EDIT_HANDLERS;
--------------------------------------------------------------------------------
FUNCTION CHECK_BOX_FACTORY(
    par_table_name VARCHAR2)
  RETURN VARCHAR2
AS
BEGIN
  -- TODO: Implementation required for FUNCTION JAVAFX_CONTROLLER_SYNTH.CHECK_BOX_FACTORY
  RETURN NULL;
END CHECK_BOX_FACTORY;
--------------------------------------------------------------------------------
FUNCTION SHOW_RESULTS(
    PAR_CONTROLLER   VARCHAR2,
    PAR_DISPLAY_TYPE VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out   VARCHAR2(32000);
  lc_table VARCHAR2(200) := parent_table(par_controller);

BEGIN
  -- Connection manager for getting database connection
  csh.MAP_PARS(lc_table);
  ADD_LN(LC_OUT, 'public void showResults(Integer results) {');
  IF (upper(par_display_type) = 'TABLE') THEN
    ADD_LN(LC_OUT, TABLE_VIEW(LC_TABLE));
  elsif (upper(par_display_type) = 'GRID') THEN
    add_ln(lc_out, GRID_VIEW(lc_table));
  END IF;
  add_ln(lc_out, '');

  -- Close function bracket
  add_ln(lc_out, '}');
  RETURN lc_out;
END SHOW_RESULTS;
--------------------------------------------------------------------------------
FUNCTION SET_STAGE
  RETURN VARCHAR2
IS

  lc_out VARCHAR2(32000);

BEGIN
  add_ln(lc_out, 'public void setStage(Stage newStage) {');
  add_ln(lc_out, '    stage = newStage;');
  add_ln(lc_out, '}');
  RETURN lc_out;
END SET_STAGE;
--------------------------------------------------------------------------------
FUNCTION INIT_OBJECT(
    par_controller VARCHAR2)
  RETURN VARCHAR2
IS

  lc_out        VARCHAR2(32000);
  lc_table      VARCHAR2(2000) := parent_table(par_controller);
  lc_table_name VARCHAR2(2000) := csh.camel_tablename_wob(lc_table);
  lc_instance   VARCHAR2(2000) := csh.camel_tablename_wob(lc_table, true);
  lc_child_instance varchar2(2000);
  
BEGIN
  add_ln(lc_out, 'public void initObject('||lc_table_name||' newInstance) {');
  add_ln(lc_out, '');
  --TODO figure out some params stuff for the resource
  ADD_LN(LC_OUT, LC_INSTANCE||' = newInstance;');
  add_ln(lc_out, 'GridPane '||lc_instance||'Grid = '||lc_instance||'.getGrid(true);');
  ADD_LN(LC_OUT, 'CssLoader css = new CssLoader("/applicationanalyzer/FXML/CSS/'||LC_TABLE_NAME||'.css", "'||LC_INSTANCE||'Grid");');
  ADD_LN(LC_OUT, LC_INSTANCE||'Grid.getColumnConstraints().add(new ColumnConstraints(css.GRID_COL1_WIDTH));');
  ADD_LN(LC_OUT, LC_INSTANCE||'Grid.getColumnConstraints().add(new ColumnConstraints(css.GRID_COL2_WIDTH));');
  add_ln(lc_out, lc_instance||'Grid.getStyleClass().add("'||lc_instance||'Grid");');
  add_ln(lc_out, lc_instance||'Pane.getChildren().add('||lc_instance||'Grid);');
  
  for rChildren in cControllerChildren(par_controller)
  loop
   lc_child_instance := csh.camel_tablename_wob(rChildren.ach_table, true);
   IF (RCHILDREN.ACH_VIEW_TYPE = 'TABLE') THEN
      add_ln(lc_out, 'TableView appChecksTable;');
      add_ln(lc_out, table_view(rChildren.ach_table));
   elsif (rChildren.ach_view_type = 'GRID') then
      add_ln(lc_out, grid_view(rChildren.ach_table));
   end if;
   add_ln(lc_out, lc_child_instance||'Pane.getChildren().add('||lc_child_instance||initcap(rChildren.ach_view_type)||');');
  end loop;

  add_ln(lc_out, '}');

  RETURN lc_out;
END INIT_OBJECT;


END JAVAFX_CONTROLLER_SYNTH;

/
