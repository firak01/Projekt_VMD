@echo off
REM KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.

REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start testFlaka hello

REM call ant -buildfile testFlaka_Patton.xml
call ant -f testFlaka_hello.xml

echo Ende testFlaka hello
pause
REM timeout /T 20 /nobreak