@echo off
REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Das nur unter Windows DOS Box aufrufen, unter Eclipse werden die Pfade nicht gefunden.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start Copy Repository to Local HOST

SET TRYOUT_ANT="Das ist ein Test"
SET VMD="C:/1fgl/repository/Projekt_VMD"
call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml

echo Ende Copy Repository to Local HOST
pause
REM timeout /T 20 /nobreak