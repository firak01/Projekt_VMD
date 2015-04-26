REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start Copy Client to Export HOST

call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml

echo Ende Copy Client to Export HOST
pause
REM timeout /T 20 /nobreak