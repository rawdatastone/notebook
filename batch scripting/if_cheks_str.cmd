@ECHO off
SET printVariables=Y
SET IllegallArguments=false 

SETLOCAL EnableDelayedExpansion 
SET errLevel=0

:: ******** check input variables and import others ********************
IF x%1==x GOTO usageerror
IF x%2==x GOTO usageerror

:: ******* Assign argument to variables
SET a=%1
SET b=%2

ECHO a: %a%
ECHO b: %b%

@REM IF NOT %a%==one IF NOT %b%==zero SET IllegallArguments=true
@REM IF %IllegallArguments%==true GOTO :illegal_argument

@REM IF NOT %a%==one IF NOT %b%==zero GOTO :illegal_argument

::IF %a%==two IF %b%==three GOTO illegal_argument
IF NOT %a%==zero IF NOT %a%==one GOTO illegal_argument
IF %a%==one GOTO Ais1 
IF %a%==zero GOTO Ais0
IF %b%==zero GOTO Bis0
GOTO end

:: ******* sub routines ********
:Ais1
ECHO .
ECHO "A equals one"
GOTO end 

:Ais0
ECHO .
ECHO "A equals zero"
GOTO end 

:Bis0
ECHO .
ECHO "B equals zero"
GOTO end 

:: ******* exit routes ********
:usageerror
SET exitMsg=Did something wrong
GOTO error

:illegal_argument
SET exitMsg=Illegal Arguments used
GOTO error

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%
