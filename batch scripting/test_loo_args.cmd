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
:: *
:: ***********************************************************************************

SETLOCAL EnableDelayedExpansion 
SET errLevel=0

:: ******** check input variables and import others ********************
IF x%1==x GOTO usageerror
IF x%2==x GOTO usageerror
IF x%3==x GOTO usageerror
SET commit=%1
SET instanceAlias=%2
SET packageNames=%3

:Loop 

IF "%1"=="" GOTO completed 
FOR %%F IN (%1) DO echo %%F 
SHIFT 
GOTO Loop 
:completed

:: ******* print imported variables ******
IF x%printVariables%==xY (
  ECHO.
  ECHO SqlCmd="%SqlCmd%"
  ECHO DevEnv="%DevEnv%"
)
  
echo **************************************************************************
echo *** Deploy.cmd *** Registering deployment of commit %commit%
echo **************************************************************************
  :: ***************************************************************************************************************************************
ECHO %1
ECHO %2
ECHO %3
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
::osql -S %DbServer% -E -Q "UPDATE <db_name>_Admin.dbo.AutomatedDeployment SET FinishDateTime = GETDATE(), ExitCode = %errLevel%, ErrorMessage = '%exitMsg%' WHERE DeploymentId = (SELECT MAX(DeploymentId) FROM <db_name>_Admin.dbo.AutomatedDeployment WHERE CommitSha1 = '%commit%')"
EXIT /b %errLevel%