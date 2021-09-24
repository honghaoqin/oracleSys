@echo off

cd %~dp0

set dir=%cd%

set username=qjsys
set password=qjsys
set listener=192.168.2.144

set fn=qjsys_20130130133809.dmp

imp %username%/%password%@%listener% file="%dir%\%fn%" log="%dir%\%fn%.log" fromuser=qjsys touser=%username%



