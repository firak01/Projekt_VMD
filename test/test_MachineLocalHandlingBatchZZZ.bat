@echo off
CLS
REM @ECHO off schaltet das echo aus... . KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.
REM echo. schaltet das echo für diese eine Zeile wieder ein.

REM Zur verzögerten Übersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit übersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verzögerter Übersetzung voraus)
REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION


REM ###################################################################
REM Allgemeine Hinweise für die Batch Programmierung s. unter Snippets "HinweiseBatchProgrammierung.txt"

echo. 
echo.###################################################################	
echo.TESTS: Zur Ermittlung des lokal vewendeten Betriebssystems
echo.###################################################################
echo.TESTS FUER MachineLokalOsZZZ
set  "returnMachineLocalOsZZZ="

REM Anders als im Original aus dem Web, habe ich die Reihenfolge der Argumente vertauscht.
call :MachineLocalOsZZZ returnMachineLocalOsZZZ 
echo.Ergebnis="%returnMachineLocalOsZZZ%"

echo.
echo.###################################################################


REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
REM So würden lokale Variablen global gemacht, theoretisch, nutze ich noch nicht.
REM ENDLOCAL & set returnStringTrim=%myTest%
REM ENDLOCAL & set returnStringTrim=!myTest!
REM ENDLOCAL & set "returnStringTrim=!myStrReduced!"
ENDLOCAL
ENDLOCAL

REM Ohne diesen Labelaufruf werden die Unterlabels erneut aufgerufen...
GOTO:EOF

REM ##################    UNTERFUNKTIONEN #################################################
:MachineLocalOsZZZ
REM  returns the the Name of the used OS. The name is shortened to be used in a filename.
::              -- returnMachineLocalOsZZZ    [in / out] - variable to be used to return the Name of the used OS. 

SETLOCAL	
set "returnMachineLocalOs=%1"
	
REM ##########################################################################
	
REM Ermittle auf Batch Ebene das verwendete Betriebssystem, um es als Parameter über eine Umgebungsvariable an das ANT Script zu uebergeben.
FOR /F "tokens=2 delims=[]" %%a IN ('VER') DO FOR /F "tokens=2" %%b IN ("%%a") DO SET VersionNumber=%%b

FOR /F "tokens=1 delims=." %%a IN ("%VersionNumber%") DO SET VersionMajor=%%a
FOR /F "tokens=2 delims=." %%a IN ("%VersionNumber%") DO SET VersionMinor=%%a
FOR /F "tokens=3 delims=." %%a IN ("%VersionNumber%") DO SET VersionBuild=%%a

IF %VersionMajor%==6 (
	REM echo.6
	IF %VersionMinor%==4 (
		 SET VersionName=Windows 10
		 SET returnMachineLocalOs=Win10
	) ELSE (
		IF %VersionMinor%==3 (
			SET VersionName=Windows 8.1
			SET returnMachineLocalOs=Win81
		) ELSE (
			IF %VersionMinor%==2 (
				SET VersionName=Windows 8
				SET returnMachineLocalOs=Win8
			) ELSE (
				IF %VersionMinor%==1 (
					SET VersionName=Windows 7
					SET returnMachineLocalOs=Win7
				) ELSE (
					IF %VersionMinor%==0 (
						SET VersionName=Windows Vista
						SET returnMachineLocalOs=WinVi
					)
				)
			)
		)
	)
) ELSE (
	IF %VersionMajor%==5 (
		IF %VersionMinor%==2 (
			SET VersionName=Windows Server 2003
			SET returnMachineLocalOs=W2003
		) ELSE (
			IF %VersionMinor%==1 (
				SET VersionName=Windows XP
				SET returnMachineLocalOs=WinXP
			) ELSE (
				IF %VersionMinor%==0 (
					SET VersionName=Windows 2000
					SET returnMachineLocalOs=Win2k
				)
			)
		)
	) ELSE (
		IF %VersionMajor%==4 ( 				
			IF %VersionMinor%==90 (
				SET VersionName=Windows ME
				SET returnMachineLocalOs=WinME
			 ) ELSE (
				IF %VersionMinor%==10 (
					SET VersionName=Windows 98
					SET returnMachineLocalOs=W98
				) ELSE (
					IF %VersionBuild%==1381 (
						SET VersionName=Windows NT 4.0
						SET returnMachineLocalOs=WinNT
					 ) ELSE (
						IF %VersionMinor%==00 (
							SET VersionName=Windows 95
							SET returnMachineLocalOs=W95
						 )
					)
				)
			)
		) ELSE (
			IF %VersionMajor%==3 (
				SET VersionName=Windows 3.1
				SET returnMachineLocalOs=Win31
			)
		)
	)
)

ECHO Versionsnummer: %VersionNumber%
ECHO VersionMajor.VersionMinor.VersionBuild: %VersionMajor%.%VersionMinor%.%VersionBuild%
ECHO VersionName: %VersionName%
ECHO VMD_OS Kuerzel (errechnet): %returnMachineLocalOs%

GOTO :MachineLocalOsZZZEnd

:MachineLocalOsZZZEnd
(
  ENDLOCAL & REM RETURN VALUES
  ::echo.%returnMachineLocalOs%
  set "%~1=%returnMachineLocalOs%"
  exit /b
)
GOTO:EOF