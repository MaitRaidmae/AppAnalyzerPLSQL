--------------------------------------------------------
--  DDL for View ALL_UT_TEST_ARGUMENTS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HUNDISILM"."ALL_UT_TEST_ARGUMENTS" ("ARG_ID", "UT_ID", "OWNER", "OBJECT_NAME", "PACKAGE_NAME", "OBJECT_ID", "OVERLOAD", "ARGUMENT_NAME", "POSITION", "SEQUENCE", "DATA_LEVEL", "DATA_TYPE", "DEFAULT_LENGTH", "IN_OUT", "DATA_LENGTH", "DATA_PRECISION", "DATA_SCALE", "RADIX", "CHARACTER_SET_NAME", "TYPE_OWNER", "TYPE_NAME", "TYPE_SUBNAME", "TYPE_LINK", "PLS_TYPE", "CHAR_LENGTH", "CHAR_USED") AS 
  SELECT
    "ARG_ID" AS "ARG_ID"
   ,"UT_ID" AS "UT_ID"
   ,"OWNER" AS "OWNER"
   ,"OBJECT_NAME" AS "OBJECT_NAME"
   ,"PACKAGE_NAME" AS "PACKAGE_NAME"
   ,"OBJECT_ID" AS "OBJECT_ID"
   ,"OVERLOAD" AS "OVERLOAD"
   ,"ARGUMENT_NAME" AS "ARGUMENT_NAME"
   ,"POSITION" AS "POSITION"
   ,"SEQUENCE" AS "SEQUENCE"
   ,"DATA_LEVEL" AS "DATA_LEVEL"
   ,"DATA_TYPE" AS "DATA_TYPE"
   ,"DEFAULT_LENGTH" AS "DEFAULT_LENGTH"
   ,"IN_OUT" AS "IN_OUT"
   ,"DATA_LENGTH" AS "DATA_LENGTH"
   ,"DATA_PRECISION" AS "DATA_PRECISION"
   ,"DATA_SCALE" AS "DATA_SCALE"
   ,"RADIX" AS "RADIX"
   ,"CHARACTER_SET_NAME" AS "CHARACTER_SET_NAME"
   ,"TYPE_OWNER" AS "TYPE_OWNER"
   ,"TYPE_NAME" AS "TYPE_NAME"
   ,"TYPE_SUBNAME" AS "TYPE_SUBNAME"
   ,"TYPE_LINK" AS "TYPE_LINK"
   ,"PLS_TYPE" AS "PLS_TYPE"
   ,"CHAR_LENGTH" AS "CHAR_LENGTH"
   ,"CHAR_USED" AS "CHAR_USED"
  FROM
    "UT_TEST_ARGUMENTS"
  WITH READ ONLY;

   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."ARG_ID" IS 'Test Argument identifier';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."UT_ID" IS 'Test identifier';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."OWNER" IS 'Username of the owner of the object';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."OBJECT_NAME" IS 'Procedure or function name';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."PACKAGE_NAME" IS 'Package name';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."OBJECT_ID" IS 'Object number of the object';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."OVERLOAD" IS 'Overload unique identifier';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."ARGUMENT_NAME" IS 'Argument name';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."POSITION" IS 'Position in argument list, or null for function return value';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."SEQUENCE" IS 'Argument sequence, including all nesting levels';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DATA_LEVEL" IS 'Nesting depth of argument for composite types';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DATA_TYPE" IS 'Datatype of the argument';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DEFAULT_LENGTH" IS 'Length of default value for the argument';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."IN_OUT" IS 'Argument direction (IN, OUT, or IN/OUT)';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DATA_LENGTH" IS 'Length of default value for the argument';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DATA_PRECISION" IS 'Length: decimal digits (NUMBER) or binary digits (FLOAT)';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."DATA_SCALE" IS 'Digits to right of decimal point in a number';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."RADIX" IS 'Argument radix for a number';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."CHARACTER_SET_NAME" IS 'Character set name for the argument';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."TYPE_OWNER" IS 'Owner name for the argument type in case of object types';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."TYPE_NAME" IS 'Object name for the argument type in case of object types';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."TYPE_SUBNAME" IS 'Subordinate object name for the argument type in case of object types';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."TYPE_LINK" IS 'Database link name for the argument type in case of object types';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."PLS_TYPE" IS 'PL/SQL type name for numeric arguments';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."CHAR_LENGTH" IS 'Character limit for string datatypes';
   COMMENT ON COLUMN "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"."CHAR_USED" IS 'Is the byte limit (B) or char limit (C) official for this string?';
   COMMENT ON TABLE "HUNDISILM"."ALL_UT_TEST_ARGUMENTS"  IS 'Unit Test - Test Arguments imported from ALL_ARGUMENTS view';
