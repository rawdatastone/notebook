@ECHO off
CALL config.cmd DEV
ECHO RepoRoot="%RepoRoot%"
ECHO "%RepoRoot%"
IF NOT EXIST "%RepoRoot%" GOTO repoRootNotFoundError
PUSHD "%RepoRoot%"
IF !ERRORLEVEL! NEQ 0 GOTO repoRootNotFoundError


GOTO end

:repoRootNotFoundError
SET exitMsg=Git repository root folder "%RepoRoot%" not found.
GOTO error

:error
ECHO **ERROR:** %exitMsg%
IF %errLevel% EQU 0 SET errLevel=1
GOTO end

:end
EXIT /b %errLevel%