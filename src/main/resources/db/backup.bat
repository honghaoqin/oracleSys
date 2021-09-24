@echo off

cd %~dp0

set dir=%cd%

set username=qjsys
set password=qjsys
set listener=192.168.2.144

set fn=%username%_%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
set fn=%fn: =0%
if not exist "%dir%" mkdir "%dir%"

exp %username%/%password%@%listener% owner=%username% file="%dir%\%fn%.dmp" log="%dir%\%fn%.log"



