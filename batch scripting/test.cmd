@ECHO off
SET printVariables=Y

:: ***********************************************************************************
:: * test.cmd - learning how to pass arguments to ps
:: *
:: * USAGE: Deploy <COMMIT_SHA1> <TARGET_ALIAS> <PACKAGE_NAME.dtsx;> 
:: *
:: * Two potential methods of passing in the package name(s):
:: *   1. in text file, each name on new line 
:: *   2. "one_package.dtsx second_package"
:: *
:: * >test.cmd one "two;twoAndAHalf;" three
:: *
:: ***********************************************************************************

SETLOCAL EnableDelayedExpansion 
SET errLevel=0

:: ******** check input variables and import others ********************
IF x%1==x GOTO usageerror
IF x%2==x GOTO usageerror
IF x%3==x GOTO usageerror

SET packageNames=%~2%
  :: ***************************************************************************************************************************************
ECHO %1
ECHO %~2%
ECHO %3
ECHO * Assigned value to variables
ECHO *** clean
ECHO %packageNames%
ECHO *** wih quotes
ECHO "%packageNames%"
GOTO end

:: ******* exit routes ********
:usageerror
SET exitMsg=Usage %0 COMMIT_SHA1 TARGET_ALIAS PACKAGE_NAME
GOTO error

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%