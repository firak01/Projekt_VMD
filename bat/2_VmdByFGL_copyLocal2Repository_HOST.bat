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

REM Ermittle auf Batch Ebene einen Timestamp, dieser dient zuerst zur Benennung der Log-Dateien, ist aber auch im Script auslesbar.
@REM Set ups %date variable
@REM First parses month, day, and year into mm , dd, yyyy formats and then combines to be MMDDYYYY

REM WIN7, deutsch...
REM ### Lokale Unterfunktion :trim, hier nur innerhalb der FOR Schleife nutzbar und nicht als LABEL für die gesamte batch
REM echo . schaltet das ausgeschaltete Echo wieder für diese zeile ein. @ECHO off schaltet das echo aus...
Echo Datum ---- Uhrzeit ist %DATE% ---- %TIME%

REM Zur verzögerten Übersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit übersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verzögerter Übersetzung voraus)
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@echo off
For /f "tokens=1-3 delims=/." %%a in ('date /t') do (
    set myMM=%%b
	call :trimRight %%a
	set myDD=!returnStringTrim!
	REM call :trimLeft %%c
	call :trimRight %%c
	set myYYYY=!returnStringTrim!		
	REM set myYYYY=%%c
	)
For /f "tokens=1-3 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b%%c)
echo %myYYYY%_%myMM%_%myDD%_%myTime%
set VMD_DATETIME=%myYYYY%%myMM%%myDD%_%myTime%
ECHO VMD_DATETIME=%VMD_DATETIME%


ECHO HOST ist %HOST%


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
IF NOT "%1"=="" (
		REM Fehler "missing value for property" wenn -D nix dahinterstehendes hat.
		call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml -Dvmd=C:/1fgl/repository/Projekt_VMD/bat/project_vmd.properties -D%* > ..\log\log.txt 2> ..\log\error.txt
	) ELSE (
		call ant -buildfile ..\src\VMDbyFGL_HostChangesPush.xml -Dvmd=C:/1fgl/repository/Projekt_VMD/bat/project_vmd.properties  > ..\log\log.txt 2> ..\log\error.txt
	)
REM Dokumentiere jeden Lauf
REM COPY C:\1fgl\repository\Projekt_VMD\log\log.txt C:\1fgl\repository\Projekt_VMD\log\log%VMD_DATETIME%.txt
REM COPY C:\1fgl\repository\Projekt_VMD\log\error.txt C:\1fgl\repository\Projekt_VMD\log\error%VMD_DATETIME%.txt

REM timeout /T 20 /nobreak
REM nicht im Debuggen, sonst wieder einkommentieren, damit sich das Fenster schliesst: exit
echo Ende Copy Repository to Local HOST
pause

REM Ohne diesen Labelaufruf werden die Unterlabels erneut aufgerufen...
goto :eof

:trimLeft
	echo. %1
	for /f "tokens=* delims= " %%a in ("%*") do set varTrimmed=%%a
	echo."%varTrimmed%"
:trimRight
    REM Zur verzögerten Übersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit übersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verzögerter Übersetzung voraus)
	SETLOCAL ENABLEDELAYEDEXPANSION
	echo.%1
	set str=%1
	
	REM Ein wenig Grundlagenexperimente, die funktionieren
	REM echo.mit Tilde -3 ist ... der drittletzte Buchstabe von date "%date:~-3,1%"
	REM echo.mit Tilde -3 sind ... die beiden (Achtung Logik) drittletzten Buchstabe von date "%date:~-3,2%"
	
	REM set myStr="a b c d ef"
	REM echo.myStr am Anfang="%myStr%"
	REM echo.mystring mit Tilde 0 ist alles !myStr:~0!
	REM echo.mystring mit Tilde -2,1 ist ... der letzte Buchstabe "!myStr:~-2,1!"
	REM echo.mystring mit Tilde -3,1 ist ... der vorletzte Buchstabe "!myStr:~-3,1!"
	REM echo.mystring mit Tilde -3,2 ist ... der vorletzte und letzte Buchstabe "!myStr:~-3,2!"
	
	set myStr="a b c d ef "
		
	REM zur Schleife:
	REM Die Variable darf nur aus einem Buchstaben bestehen! "%t" ist erlaubt, "%test" nicht! Bei der Verwendung mehrerer Befehle muss zwischen "DO" und der Klammer "(" ein Leerzeichen sein.
	REM so würde eine Schleife rückwärts gezählt for /l %%x in (10,-1,1) do (
	REM was bedeuted das /l? Es muss etwas listenmäßiges sein und ist wichtig.... Mit solchen Schleifen kann man Aktionen eine bestimmte Anzahl oft ausführen. Dazu muss man den Parameter /L angeben.
	
	REM Zum if - Befehl
	REM Der Parameter /i unterbindet eine Differenzierung der Groß-/Kleinbuchstaben.
	REM Bei der Verwendung mehrerer Befehle muss zwischen Bedingung und der Klammer "(" ein Leerzeichen sein.
	
	REM Zum set - Befehl
	REM Der Parameter /a wird dazu verwendet rechenoperationen durchzuführen
	REM zum Ausrufezeichen
	REM Definiert eine Variable, zur Verzögerten Berechenung, d.h. erst zur Laufzeit berechnen. Siehe SETLOCAL ENABLEDELAYEDEXPANSION.
	REM Dagegen wird mit % eine Variable wohl schon beim kompilieren berechnet.
	
	
	for /l %%x in (2,1,11) do (
	REM for %%x in (2,1,11) do ( wir nur einmal ausgeführt
        echo.letzte Buchstaben bei %%x : !myStr:~-%%x,1!		
		set /a itemp=11-%%x
		echo.itemp=!itemp!
		
		set ctemp=!myStr:~-%%x,1!
		REM Beachte hier die verzoegerte Berechnung zur Lauzeit durch Ausrufezeichen ....   echo.!ctemp!
		
		if "!ctemp!"==" " (
			echo Leerstring gefunden.			
			) else (
			echo kein Leerstring
			REM https://www.administrator.de/wissen/arbeite-batch-umgebungsvariablen-erstellung-umgang-erweiterungen-ver%C3%A4nderungen-117069.html
			REM abbrechen...
			REM PROBLEM: Wie rechnet man das zur Laufzeit aus... set myStrReduced="!myStr!:~-12,!itemp!"
			REM set myStrReduced=!myStr!:~-12,!itemp!
			REM set myStrReduced=!myStr:~-12,itemp!
			set myStrReduced=!%myStr%:~-12,%itemp%!
			REM set myStrReduced=!!myStr!:~-12,!itemp!!
			
			echo.reduzierter String !myStrReduced!	
			echo.andere Syntax %myStr:~-12,4%
			goto :trimexit
			)		
	)
	:trimexit
	echo.itemp am ende !itemp!
	echo.myStr am ende="!myStrReduced!"
	set returnStringTrim=!myStrReduced!
	
	
	
	
	
	
:eof

