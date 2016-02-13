@echo off
REM KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.

REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start test_ArrayHandlingJsZZZtemp

REM Wir wollen hier keine Java Files builden
REM call ant -buildfile testFlaka_Patton.xml

REM Wir wollen hier ggfs. Dateien verarbeiten
SET TRYOUT_ANT="Das ist ein Test"
call ant -f test_ArrayHandlingJsZZZtemp.xml

echo Ende test_ArrayHandlingJsZZZ
pause
REM timeout /T 20 /nobreak