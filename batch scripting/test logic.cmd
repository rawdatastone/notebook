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
:: %4 is optional
:: ******* Assign argument to variables
SET commit=%1
SET modelType=%2
SET instanceAlias=%3
SET packageNames=%~4%

:: ******* Print out all the variables values
ECHO Value passed for commit: %commit%
ECHO Value passed for modelType: %modelType%
ECHO Value passed for instanceAlias: %instanceAlias%
ECHO Value passed for packageNames: %packageNames%

:: ******* Check if Model doesn't conflict with Instance ********
IF NOT %modelType%==Package IF NOT %modelType%==Project GOTO illegalModel
IF %modelType%==Package IF %instanceAlias%==PROD GOTO instanceModelConflict
IF %modelType%==Project GOTO ProjectDeployment 
IF %modelType%==Package GOTO PackageDeployment 

:: ******* Methods
:ProjectDeployment
ECHO .
ECHO Logic Path Results in:
ECHO Project Deployment
GOTO end

:PackageDeployment
ECHO .
ECHO Logic Path Results in:
ECHO Package Deployment
GOTO end

:: ******* exit routes ********
:usageerror
SET exitMsg=Usage %0 COMMIT_SHA1 TARGET_ALIAS PACKAGE_NAME
GOTO error

:illegalModel
SET exitMsg=Illegal model input: %modelType%. Allowable models are: Package or Project
GOTO error 

:instanceModelConflict
SET exitMsg="Package deployment model to Production is not allowed"
GOTO error 

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%