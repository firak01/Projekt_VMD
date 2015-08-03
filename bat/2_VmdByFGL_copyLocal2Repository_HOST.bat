@echo off
REM KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.

REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Das nur unter Windows DOS Box aufrufen, unter Eclipse werden die Pfade nicht gefunden.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start Copy Repository to Local HOST


REM Eine Startdatei mit den Projekteinstellungen übergeben. 
REM Merke: Der übergebenen Dateiname wird ggfs. durch die existenz eines Dateinamens project_ "Hostname des Rechners" _vmd.properties übersteuert.
REM Merke: Die Pfadangaben sind mit Slash und nicht mit Backslash

REM Varinte A) Für Batch Alternative Möglichkeit über Umgebungsvariablen Parameter zu übergeben.
SET TRYOUT_ANT="Das ist ein Test"
SET VMD="C:/1fgl/repository/Projekt_VMD"

REM Variante B) Sowohl für Eclipse (Run Konfiguration) als auch Batch. 
REM MERKE: Wenn die Batch auch aus Eclipse heraus gestartet werden soll, braucht man wohl ANT_HOME usw. als Umgebungsvariable. 
call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml -Dvmd=C:/1fgl/repository/Projekt_VMD/bat/project_vmd.properties

echo Ende Copy Repository to Local HOST
pause
REM timeout /T 20 /nobreak