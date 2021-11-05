@ECHO off

SETLOCAL EnableDelayedExpansion 
SET errLevel=0


IF x%1==x GOTO usageerror1
:: optional
IF x%2==x SET b=Project
::IF x%3==x GOTO usageerror3 
::ELSE GOTO usageerror2
:: optional, depends on 2


SET a=%1
IF NOT DEFINED b SET b=%2 
IF NOT %b%==Package IF NOT %b%==Project GOTO illegalModel
IF %b%==Package IF NOT x%3==x (SET c=%3) ELSE GOTO usageerror3

ECHO a %a%
ECHO b %b%
ECHO c %c%


@REM IF NOT %a%==zero IF NOT %a%==one GOTO illegal_argument
@REM IF %a%==one GOTO Ais1 

@REM IF NOT %modelType%==Package IF NOT %modelType%==Project GOTO illegalModel
@REM IF %modelType%==Package IF %instanceAlias%==PROD GOTO instanceModelConflict

GOTO end

:usageerror1
SET exitMsg=Variable assigment error 1
GOTO error

:illegalModel
SET exitMsg=Model type must be Package or Project
GOTO error

:usageerror3
SET exitMsg=Variable assigment error 3
GOTO error

:usageerror
SET exitMsg=Variable assigment error
GOTO error

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%