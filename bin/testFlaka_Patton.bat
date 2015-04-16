REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start testFlaka fuer Patton

REM call ant -buildfile testFlaka_Patton.xml
call ant -f testFlaka_Patton.xml

echo Ende testFlaka fuer Patton
pause
REM timeout /T 20 /nobreak