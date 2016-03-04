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
REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM Setze Wertzuweisung hinter dem SET - Befehl in Anführungszeichen, um zu verhindern, dass Leerzeichen am Ende der Zeile in den Variablenwert "reinrutschen"
@echo off
For /f "tokens=1-3 delims=/." %%a in ('date /t') do (
    set "myMM=%%b"
	
	call :trimRight %%a
	set "myDD=!returnStringTrim!"
	
	REM call :trimLeft %%c
	call :trimRight %%c	
	set "myYYYY=!returnStringTrim!"	
	)

REM Bei aktivierter Befehlserweiterung wird mit /t verhindert, dass die Eingabe einer neuen Zeit (oder ENTER DRUECKEN) erfolgt.
REM Das gibt nur Stunden und Minuten aus For /f "tokens=1-4 delims=/:" %%a in ('time /t') do (set "mytime=%%a%%b%%c")
REM Das gibt zwar auch Sekunden aus, aber die Stundenzahl ist nicht zweistellig und die Millisekunden will ich nicht 
REM For /f "tokens=1-4 delims=/:." %%a in ('echo %time%') do (set "mytime=%%a%%b%%c")

REM TODO GOON 20160304
For /f "tokens=1-4 delims=/:." %%a in ('echo %time%') do (set "mytime=%%a%%b%%c")
echo !myYYYY!_!myMM!_!myDD!_!myTime!
set "VMD_DATETIME=!myYYYY!!myMM!!myDD!_!myTime!"
ECHO VMD_DATETIME=!VMD_DATETIME!

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

REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
REM So würden lokale Variablen global gemacht, theoretisch, nutze ich noch nicht.
REM ENDLOCAL & set returnStringTrim=%myTest%
REM ENDLOCAL & set returnStringTrim=!myTest!
REM ENDLOCAL & set "returnStringTrim=!myStrReduced!"
ENDLOCAL
ENDLOCAL

REM Ohne diesen Labelaufruf werden die Unterlabels erneut aufgerufen...
goto:eof

:trimLeft
	echo. %1
	for /f "tokens=* delims= " %%a in ("%*") do set varTrimmed=%%a
	echo."%varTrimmed%"
:trimRight
	REM Originalcode
	REM set str=15 Trailing Spaces to truncate               &rem
	REM echo."%str%"
	REM for /l %%a in (1,1,31) do if "!str:~-1!"==" " set str=!str:~0,-1!
	REM echo."%str%"

    REM Zur verzögerten Übersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit übersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verzögerter Übersetzung voraus)	
	echo.Start von trimRight mit: "%1"
	set "myStr=%1"
	
	REM Einige Grundlagenexperimente zur Stringverarbeitung, die funktionieren
	REM set myStr="a b c d ef "		
	REM echo.myStr am Anfang="%myStr%"
	REM echo.mit Tilde -3 ist ... der drittletzte Buchstabe von date "%date:~-3,1%"
	REM echo.mit Tilde -3 sind ... die beiden (Achtung Logik) drittletzten Buchstabe von date "%date:~-3,2%"
	
	REM echo.mystring mit Tilde 0 ist alles !myStr:~0!
	REM echo.mystring mit Tilde -2,1 ist ... der letzte Buchstabe "!myStr:~-2,1!"
	REM echo.mystring mit Tilde -3,1 ist ... der vorletzte Buchstabe "!myStr:~-3,1!"
	REM echo.mystring mit Tilde -3,2 ist ... der vorletzte und letzte Buchstabe "!myStr:~-3,2!"
	
	
	REM zur Schleife:
	REM Die Variable darf nur aus einem Buchstaben bestehen! "%t" ist erlaubt, "%test" nicht! Bei der Verwendung mehrerer Befehle muss zwischen "DO" und der Klammer "(" ein Leerzeichen sein.
	REM so würde eine Schleife rückwärts gezählt for /l %%x in (10,-1,1) do (
	REM was bedeuted das /l. Es muss etwas listenmäßiges sein und ist wichtig?.... Lösung: Mit solchen Schleifen kann man Aktionen eine bestimmte Anzahl oft ausführen. Dazu muss man den Parameter /L angeben.
	
	REM Zum if - Befehl
	REM Der Parameter /i unterbindet eine Differenzierung der Groß-/Kleinbuchstaben.
	REM Bei der Verwendung mehrerer Befehle muss zwischen Bedingung und der Klammer "(" ein Leerzeichen sein.
	
	REM Zum set - Befehl
	REM Der Parameter /a wird dazu verwendet Rechenoperationen durchzuführen
	REM zum Ausrufezeichen
	REM Definiert eine Variable, zur Verzögerten Berechenung, d.h. erst zur Laufzeit berechnen. Siehe SETLOCAL ENABLEDELAYEDEXPANSION.
	REM Dagegen wird mit % eine Variable wohl schon beim kompilieren berechnet.
	REM TIP: Setze die Wertzuweisung hinter sem SET in Anführungszeichen, damit soll verhindert werden, dass unbeabsichtigte Leerzeichen am Ende der Zeiel in den Wert rutschen.
	REM      Das ist bei mathematischen SET Rechenoperationen nicht notwendig
	
	
	REM TODO: Hole die Länge des zu trimmenden Strings
	
	for /l %%x in (2,1,11) do (
	REM for %%x in (2,1,11) do ( würde wegen fehlendem /l nur einmal ausgeführt
        echo.letzte Buchstaben bei %%x : !myStr:~-%%x,1!		
		
		REM Länge des Strings +2 Minus Zählvariable. Die Zählvariable startet bei 2!
		set /a itemp=13-%%x
		
		REM Beachte hier die verzoegerte Berechnung zur Laufzeit durch Ausrufezeichen ....   
		echo.itemp=!itemp!
		
		REM Beachte hier die verzoegerte Berechnung zur Laufzeit durch Ausrufezeichen ....   
		set ctemp=!myStr:~-%%x,1!
		echo.!ctemp!
		if "!ctemp!"==" " (
			echo Leerstring gefunden, Schleife fortsetzen.
			) else (
			echo kein Leerstring, Schleife abbrechen.
			REM https://www.administrator.de/wissen/arbeite-batch-umgebungsvariablen-erstellung-umgang-erweiterungen-ver%C3%A4nderungen-117069.html
			REM abbrechen...
			REM PROBLEM: Wie rechnet man das zur Laufzeit aus... set myStrReduced="!myStr!:~-12,!itemp!"
			REM Nicht funktionierendes:
			REM set myStrReduced=!myStr!:~-12,!itemp!
			REM set myStrReduced=!myStr:~-12,itemp!
			REM set myStrReduced=!%myStr%:~-12,%itemp%!
			REM set myStrReduced=!!myStr!:~-12,!itemp!!
			REM funktioniert echo.andere Syntax %myStr:~-12,4%
			REM funktioniert aber nicht nicht echo.kombinations-syntax %myStr:~-12,!itemp!%
			
			REM nein set myStrReduced=%!myStr!:~-12,!itemp!%
			REM nein call set myStrReduced=%%!myStr!:~-12,9%			
			call set "myStrReduced=%%myStr:~-12,!itemp!%%"
			echo.reduzierter String "!myStrReduced!"
							
			REM Beispiele zur Lösungsfindung
			REM funktionierendes Beispiel01:
			REM setlocal enabledelayedexpansion
			REM set string=This is my string to work with.
			REM echo.anderesBeispiel !string!
			REM set find=my string
			REM set replace=your replacement
			REM call set string=%%string:!find!=!replace!%%
			REM echo.anderesBeispiel !string!
						
			REM funktionierendes Beispiel02:
			REM setlocal enabledelayedexpansion
			REM set string=This is my string to work with.
			REM call set string=%%string:to work with.=%%
			REM echo.anderesBeispiel02 !string!
			
			set "returnStringTrim=!myStrReduced!"			
			GOTO:EOF
			)		
	)
	set "returnStringTrim="			
	GOTO:EOF
	