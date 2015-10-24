@echo off
REM 1) KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.
REM 2) Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist (aus einem JDK). 

echo start Copy Repository to Local HOST
echo uebergebener Parameter 1: %1
echo uebergebener Parameter 2: %2
echo alle Parameter: %*

REM Ermittle auf Batch Ebene das verwendete Betriebssystem, um es als Parameter über eine Umgebungsvariable an das ANT Script zu uebergeben.
FOR /F "tokens=2 delims=[]" %%a IN ('VER') DO FOR /F "tokens=2" %%b IN ("%%a") DO SET VersionNumber=%%b

FOR /F "tokens=1 delims=." %%a IN ("%VersionNumber%") DO SET VersionMajor=%%a
FOR /F "tokens=2 delims=." %%a IN ("%VersionNumber%") DO SET VersionMinor=%%a
FOR /F "tokens=3 delims=." %%a IN ("%VersionNumber%") DO SET VersionBuild=%%a

IF %VersionMajor%==6 (
		 IF %VersionMinor%==4 (
		 		 SET VersionName=Windows 10
				 SET VMD_OS=Win10
		 ) ELSE (
		 IF %VersionMinor%==3 (
		 		 SET VersionName=Windows 8.1
				 SET VMD_OS=Win81
		 ) ELSE (
		 IF %VersionMinor%==2 (
		 		 SET VersionName=Windows 8
				 SET VMD_OS=Win8
		 ) ELSE (
		 IF %VersionMinor%==1 (
		 		 SET VersionName=Windows 7
				 SET VMD_OS=Win7
		 ) ELSE (
		 IF %VersionMinor%==0 (
		 		 SET VersionName=Windows Vista
				 SET VMD_OS=WinVi
		 )))))
) ELSE (
IF %VersionMajor%==5 (
		 IF %VersionMinor%==2 (
		 		 SET VersionName=Windows Server 2003
				 SET VMD_OS=W2003
		 ) ELSE (
		 IF %VersionMinor%==1 (
		 		 SET VersionName=Windows XP
				 SET VMD_OS=WinXP
		 ) ELSE (
		 IF %VersionMinor%==0 (
		 		 SET VersionName=Windows 2000
				 SET VMD_OS=Win2k
		 )))
) ELSE (
IF %VersionMajor%==4 ( ECHO 4
		 IF %VersionMinor%==90 (
		 		 SET VersionName=Windows ME
				 SET VMD_OS=WinME
		 ) ELSE (
		 IF %VersionMinor%==10 (
		 		 SET VersionName=Windows 98
				 SET VMD_OS=W98
		 ) ELSE (
		 IF %VersionBuild%==1381 (
		 		 SET VersionName=Windows NT 4.0
				 SET VMD_OS=WinNT
		 ) ELSE (
		 IF %VersionMinor%==00 (
		 		 SET VersionName=Windows 95
				 SET VMD_OS=W95
		 ))))
) ELSE (
IF %VersionMajor%==3 (
		 SET VersionName=Windows 3.1
		 SET VMD_OS=Win31
))))

ECHO Versionsnummer: %VersionNumber%
ECHO VersionMajar.VersionMinor.VersionBuild: %VersionMajor%.%VersionMinor%.%VersionBuild%
ECHO VersionName: %VersionName%
ECHO VMD_OS Kuerzel (errechnet): %VMD_OS%



REM Eine Startdatei mit den Projekteinstellungen übergeben. 
REM Merke: Der übergebenen Dateiname wird ggfs. durch die existenz eines Dateinamens project_ "Hostname des Rechners" _vmd.properties übersteuert.
REM Merke: Die Pfadangaben sind mit Slash und nicht mit Backslash

REM Varinte A) Für Batch Alternative Möglichkeit über Umgebungsvariablen Parameter zu übergeben.
REM Das nur unter Windows DOS Box aufrufen, unter Eclipse werden die Pfade nicht gefunden.
SET TRYOUT_ANT="Das ist ein Test"
SET VMD="C:/1fgl/repository/Projekt_VMD"

REM Variante B) Sowohl für Eclipse (Run Konfiguration) als auch Batch. 
REM MERKE: Wenn die Batch auch aus Eclipse heraus gestartet werden soll, braucht man wohl ANT_HOME usw. als Umgebungsvariable. 
REM Mit -D wird eine Parameter übergeben. Ohne -D wird davon ausgegangen, dass dies der Targetname in dem AntScript ist, der gestartet werden soll.
REM                                                          Z.B. call ant -buildfile test.xml -Dparam1 -Dparam2 blabla
REM                                                          Hier soll das Target blabla ausgeführt werden. Ohne solch eine Targetangabe wird gestartet was unter <project ... default="..." > angegeben ist.
REM %* gibt alle Parameter aus, mit denen diese Batch aufgerufen wurde. Diese werden an Ant weitergegeben.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml -Dvmd=C:/1fgl/repository/Projekt_VMD/bat/project_vmd.properties -D%*

echo Ende Copy Repository to Local HOST
pause
REM timeout /T 20 /nobreak
exit