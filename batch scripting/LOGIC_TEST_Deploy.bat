@ECHO off
SET printVariables=Y

:: ***********************************************************************************
:: * 
:: * Deploy.cmd - deployment script for <name> deployment pipeline
:: *
:: *         !!! MUST EXECUTE IN COMMAND PROMPT NOT POWERSHELL !!!
:: * 
:: * USAGE: Deploy <COMMIT_SHA1> <DEV/TEST> <Project/Pakcage> "<PACKAGE_NAME_1.dtsx;PACKAGE_NAME_2.dtsx;>"
:: * 
:: * The last 2 arguments are optional
:: * 
:: * EXAMPLE: 
:: *  Deploy entire Project by building and ipsac
:: *     Deploy.cmd 2d47f0d PROD 
:: *
:: *  Deploy individual package(s)
:: *     Deploy.cmd 2d47f0d DEV  Package "TEST_DeployScript_SinglePackage2.dtsx;TEST_DeployScript_SinglePackage3.dtsx;"
:: *     Deploy.cmd 2d47f0d DEV  Package "TEST_DeployScript_SinglePackage1.dtsx;"
:: * 
:: ***********************************************************************************


:: ******** check input variables and import others ********************
IF x%1==x GOTO usageerror
IF x%2==x GOTO usageerror
SET commit=%1
SET instanceAlias=%2

IF x%3==x (SET modelType=Project) ELSE (SET modelType=%3)
:: ******* Check if Model doesn't conflict with Instance  ********
IF NOT %modelType%==Package IF NOT %modelType%==Project GOTO illegalModel
IF %modelType%==Package IF NOT %instanceAlias%==DEV IF NOT %instanceAlias%==TEST GOTO instanceModelConflict
IF %modelType%==Package IF NOT x%4==x (SET packageNames=%~4%) ELSE GOTO usageerror


ECHO.....................................................
ECHO Passed Arguments:
ECHO sha1: %commit%
ECHO instanceAlias: %instanceAlias%
ECHO modelType: %modelType%
ECHO packageNames: "%packageNames%"
ECHO.....................................................
GOTO end
:: ***************************************************************************************************************************************
:: ******* exit routes ********
:usageerror
SET exitMsg=Usage %0 COMMIT_SHA1 TARGET_ALIAS MODE PACKAGE_NAMES
GOTO error
 
:repoRootNotFoundError
SET exitMsg=Git repository root folder "%RepoRoot%" not found.
GOTO error
 
:checkoutError
SET exitMsg=Error checking out commit "%commit%".
GOTO error
  
:scriptFolderNotFoundError
SET exitMsg=Script folder "%iScriptFolder%" not found.
GOTO error
 
:abort
SET exitMsg=Deployment aborted at user request 
SET errLevel=255
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
