@echo off
REM KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.

REM Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist.
REM Unbedingt mit call aufrufen, sonst werden nachfolgende Anweisungen nicht mehr ausgeführt.
echo start test_MathHandlingJsZZZ

REM Wir wollen hier keine Java Files builden
REM call ant -buildfile testFlaka_Patton.xml

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

call ant -f test_MathHandlingJsZZZ.xml

echo Ende test_MathHandlingJsZZZ
pause
REM timeout /T 20 /nobreak