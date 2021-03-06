--------------------------------------------------------
--  DDL for View ALL_UT_SUITE_RESULTS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HUNDISILM"."ALL_UT_SUITE_RESULTS" ("UTSR_ID", "UT_SID", "NAME", "STATUS", "MESSAGE", "STARTUP_STATUS", "STARTUP_MESSAGE", "STARTUP_START_TIME", "STARTUP_END_TIME", "STARTUP_DURATION", "TEARDOWN_STATUS", "TEARDOWN_MESSAGE", "TEARDOWN_START_TIME", "TEARDOWN_END_TIME", "TEARDOWN_DURATION", "RUN_DATE") AS 
  SELECT
    "UTSR_ID" AS "UTSR_ID"
   ,"UT_SID" AS "UT_SID"
   ,"NAME" AS "NAME"
   ,"STATUS" AS "STATUS"
   ,"MESSAGE" AS "MESSAGE"
   ,"STARTUP_STATUS" AS "STARTUP_STATUS"
   ,"STARTUP_MESSAGE" AS "STARTUP_MESSAGE"
   ,"STARTUP_START_TIME" AS "STARTUP_START_TIME"
   ,"STARTUP_END_TIME" AS "STARTUP_END_TIME"
   ,"STARTUP_DURATION" AS "STARTUP_DURATION"
   ,"TEARDOWN_STATUS" AS "TEARDOWN_STATUS"
   ,"TEARDOWN_MESSAGE" AS "TEARDOWN_MESSAGE"
   ,"TEARDOWN_START_TIME" AS "TEARDOWN_START_TIME"
   ,"TEARDOWN_END_TIME" AS "TEARDOWN_END_TIME"
   ,"TEARDOWN_DURATION" AS "TEARDOWN_DURATION"
   ,"RUN_DATE" AS "RUN_DATE"
  FROM
    "UT_SUITE_RESULTS"
  WITH READ ONLY;

   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."UTSR_ID" IS 'Suite Result identifier';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."UT_SID" IS 'Suite identifier';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."NAME" IS 'Result name';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STATUS" IS 'Result status';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."MESSAGE" IS 'Result message, if any';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STARTUP_STATUS" IS 'Startup status';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STARTUP_MESSAGE" IS 'Startup message, if any';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STARTUP_START_TIME" IS 'Start time of suite startup in formated text';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STARTUP_END_TIME" IS 'End time of suite startup in formated text';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."STARTUP_DURATION" IS 'Duration of suite startup in milliseconds';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."TEARDOWN_STATUS" IS 'Teardown status';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."TEARDOWN_MESSAGE" IS 'Teardown message, if any';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."TEARDOWN_START_TIME" IS 'Start time of suite teardown in formated text';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."TEARDOWN_END_TIME" IS 'End time of suite teardown in formated text';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."TEARDOWN_DURATION" IS 'Duration of suite teardown in milliseconds';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_SUITE_RESULTS"."RUN_DATE" IS 'Suite run timestamp';
   COMMENT ON TABLE "HUNDISILM"."ALL_UT_SUITE_RESULTS"  IS 'Unit Test - Suite Results';
