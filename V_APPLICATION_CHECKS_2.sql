--------------------------------------------------------
--  DDL for View V_APPLICATION_CHECKS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HUNDISILM"."V_APPLICATION_CHECKS" ("APL_CODE", "CHK_MNEMO", "CHK_VALUE", "RUN_DATE", "RUN_COMMENT") AS 
  (SELECT APP."APL_CODE",
    (SELECT CHK_MNEMO FROM B_CHECKS WHERE CHK_CODE = CHK.ACK_CHK_CODE
    ) AS CHK_MNEMO, CHK.ACK_VALUE AS CHK_VALUE,
    (SELECT SRN_DATE FROM B_SUITE_RUNS WHERE SRN_CODE = CHK.ACK_SRN_CODE
    ) AS RUN_DATE,
    (SELECT SRN_COMMENT FROM B_SUITE_RUNS WHERE SRN_CODE = CHK.ACK_SRN_CODE
    ) AS RUN_COMMENT
  FROM b_applications app
  JOIN b_app_checks chk
  ON ACK_APL_CODE = APL_CODE
  );
