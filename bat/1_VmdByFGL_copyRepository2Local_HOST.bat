@echo off
REM KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.

REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgef�hrt.
echo start Copy Local to Repository HOST

call ant -buildfile ..\src\VMDbyFGL_HostChangesPull.xml

echo Ende Copy Local to Repository HOST
pause
REM timeout /T 20 /nobreak