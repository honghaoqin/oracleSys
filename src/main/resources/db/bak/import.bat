@echo off

cd %~dp0

set dir=%cd%

set username=libysys
set password=libysys
set listener=ORCL

set fn=libysys20160819.dmp

imp %username%/%password%@%listener% file="%dir%\%fn%" log="%dir%\%fn%.log" fromuser=libysys touser=%username%



