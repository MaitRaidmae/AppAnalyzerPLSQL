--------------------------------------------------------
--  DDL for Package Body P_CHECK_SUITS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HUNDISILM"."P_CHECK_SUITS" AS

  PROCEDURE UPDATE_ROW(par_code NUMBER, par_mnemo varchar2, par_comment VARCHAR2) AS
  BEGIN
    UPDATE b_Check_suits
    SET 
    chs_mnemo = par_mnemo,
    chs_comment = par_comment
    where chs_code = par_code;
    
  END UPDATE_ROW;

END P_CHECK_SUITS;

/
