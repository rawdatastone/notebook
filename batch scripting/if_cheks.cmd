@ECHO off
SET printVariables=Y

SETLOCAL EnableDelayedExpansion 
SET errLevel=0

:: ******** check input variables and import others ********************
IF x%1==x GOTO usageerror
IF x%2==x GOTO usageerror

:: ******* Assign argument to variables
SET /A a=%1
SET /A b=%2

ECHO a: %a%
ECHO b: %b%


IF %a%==0 GOTO Ais1
IF %b%==0 GOTO Bis0
GOTO end
:: ******* sub routines ********
:Ais1
ECHO .
ECHO "A equals 1"
GOTO end 

:Bis0
ECHO .
ECHO "B equals 0"
GOTO end 

:: ******* exit routes ********
:usageerror
SET exitMsg=Did something wrong
GOTO error

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%
