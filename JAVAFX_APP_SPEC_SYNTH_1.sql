--------------------------------------------------------
--  DDL for Package Body JAVAFX_APP_SPEC_SYNTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."JAVAFX_APP_SPEC_SYNTH" 
AS

FUNCTION MOUSE_EVENT_HANDLER(
    PAR_CONTROLLER VARCHAR2)
  RETURN VARCHAR2
IS

  LC_OUT VARCHAR2(32000);
  LC_TABLE VARCHAR2(2000);
BEGIN

  SELECT ACO_TABLE INTO LC_TABLE FROM B_APP_CONTROLLERS WHERE ACO_CONTROLLER = PAR_CONTROLLER;
  
  -- TODO: Implementation required for FUNCTION JAVAFX_APP_SPEC_SYNTH.MOUSE_EVENT_HANDLER
  CASE (upper(LC_TABLE))
  WHEN 'B_APPLICATIONS' THEN
    ADD_LN(lc_out, 'private EventHandler<MouseEvent> MouseEventHandler(TableRow<Applications> row) {');
    ADD_LN(lc_out, 'EventHandler<MouseEvent> mouseEvent');
    ADD_LN(lc_out, '= new EventHandler<MouseEvent>() {');
    ADD_LN(lc_out, '@Override');
    ADD_LN(lc_out, 'public void handle(final MouseEvent event) {');
    Add_ln(lc_out, 'Applications currApp = row.getItem();');
    ADD_LN(lc_out, 'if (event.getClickCount() >= 2) {');
    ----------------------------------------------------------------------------
    ADD_LN(lc_out, 'try {');
    ADD_LN(lc_out, 'FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/applicationanalyzer/FXML/ApplicationChecks.fxml"));');
    ADD_LN(lc_out, 'AnchorPane page = (AnchorPane) fxmlLoader.load();');
    ADD_LN(lc_out, 'Stage editStage = new Stage();');
    ADD_LN(lc_out, 'editStage.setTitle("Application Checks for: " + currApp.getAplName());');
    ADD_LN(LC_OUT, 'editStage.initModality(Modality.WINDOW_MODAL);');
    ADD_LN(lc_out, 'editStage.initOwner('||csh.snake_to_camel(par_controller,true)||'.getScene().getWindow());');
    ADD_LN(lc_out, 'Scene scene = new Scene(page);');
    ADD_LN(lc_out, 'editStage.setScene(scene);');
    ADD_LN(lc_out, 'scene.getStylesheets().add("/applicationanalyzer/FXML/CSS/ApplicationChecks.css");');
    ADD_LN(lc_out, 'ApplicationChecksController controller = fxmlLoader.getController();');
    ADD_LN(lc_out, 'controller.initObject(currApp);');
    ADD_LN(lc_out, 'controller.setStage(editStage);');
    ADD_LN(lc_out, 'editStage.showAndWait();');
    ADD_LN(lc_out, '} catch (IOException e) {');
    ADD_LN(lc_out, 'Alerts.AlertIO(e);');
    ADD_LN(lc_out, '}');
    ---------------------------------------------------------------------------    
    ADD_LN(lc_out, '} else if (event.getButton() == MouseButton.SECONDARY) {');
    ADD_LN(lc_out, '// Add rightClick Event here (open popupMenu for example');
    ADD_LN(lc_out, '}');
    ADD_LN(lc_out, '}');
    ADD_LN(lc_out, '};');
    ADD_LN(lc_out, 'return mouseEvent;');
    ADD_LN(lc_out, '}');
  ELSE
    ADD_LN(lc_out, 'private EventHandler<MouseEvent> MouseEventHandler(TableRow<Applications> row) {');
    ADD_LN(lc_out, '    EventHandler<MouseEvent> mouseEvent');
    ADD_LN(lc_out, '= new EventHandler<MouseEvent>() {');
    ADD_LN(lc_out, '@Override');
    ADD_LN(lc_out, 'public void handle(final MouseEvent event) {');
    ADD_LN(lc_out, 'if (event.getClickCount() >= 2) {');
    ADD_LN(lc_out, '//Add DoubleClick Event here');
    ADD_LN(lc_out, '} else if (event.getButton() == MouseButton.SECONDARY) {');
    ADD_LN(lc_out, '// Add rightClick Event here (open popupMenu for example');
    ADD_LN(lc_out, '}');
    ADD_LN(lc_out, '}');
    ADD_LN(lc_out, '};');
    ADD_LN(lc_out, 'return mouseEvent;');
    ADD_LN(lc_out, '}');

  END CASE;

  RETURN lc_out;
END MOUSE_EVENT_HANDLER;

END JAVAFX_APP_SPEC_SYNTH;

/
