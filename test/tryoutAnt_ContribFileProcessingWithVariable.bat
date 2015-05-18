REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start tryoutAnt_ContribFileProcessingWithVariable

REM Wir wollen hier keine Java Files builden
REM call ant -buildfile testFlaka_Patton.xml

REM Wir wollen hier nicht auf umgebungsvariablen zugreifen SET TRYOUT_ANT="Das ist ein Test"

REM Wir wollen hier ggfs. Dateien verarbeiten
call ant -f tryoutAnt_ContribFileProcessingWithVariable.xml

echo Ende tryoutAnt_ContribFileProcessingWithVariable
pause
REM timeout /T 20 /nobreak