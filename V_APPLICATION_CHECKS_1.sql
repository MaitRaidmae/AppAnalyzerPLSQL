--------------------------------------------------------
--  DDL for View V_APPLICATION_CHECKS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HUNDISILM"."V_APPLICATION_CHECKS" ("APL_CODE", "CHK_MNEMO", "CHK_VALUE", "RUN_DATE", "RUN_COMMENT") AS 
  (select APP."APL_CODE", 
(select CHK_MNEMO from B_CHECKS where CHK_CODE = CHK.ACK_CHK_CODE) as CHK_MNEMO,
CHK.ACK_VALUE as CHK_VALUE,
(select SRN_DATE from B_SUIT_RUNS where SRN_CODE = CHK.ACK_SRN_CODE) as RUN_DATE,
(select SRN_COMMENT from B_SUIT_RUNS where SRN_CODE = CHK.ACK_SRN_CODE) as RUN_COMMENT
FROM b_applications app JOIN  b_app_checks chk ON 
ACK_APL_CODE=APL_CODE);
