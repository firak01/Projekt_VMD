@echo off
CLS
REM 1) KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.
REM 2) Verwendet wird ant. Voraussetzung ist also das Java Ant - Tool installiert ist (aus einem JDK). 

REM Zur verzögerten Übersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit übersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verzögerter Übersetzung voraus)
REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo start Copy Repository to Local HOST
echo uebergebener Parameter 1: %1
echo uebergebener Parameter 2: %2
echo alle Parameter: %*

REM Ermittle auf Batch Ebene das verwendete Betriebssystem, um es als Parameter über eine Umgebungsvariable an das ANT Script zu uebergeben.
SET "returnMachineLocalOs="
call :MachineLocalOsZZZ returnMachineLocalOs
set "VMD_OS=!returnMachineLocalOs!"
ECHO VMD_OS Kuerzel (errechnet): %VMD_OS%

REM #################################################################################
REM Ermittle auf Batch Ebene einen Timestamp, dieser dient zuerst zur Benennung der Log-Dateien, ist aber auch im Script auslesbar.
set "returnDateTimestampCurrentZZZ="
call :DateTimestampCurrentZZZ returnDateTimestampCurrentZZZ
set "VMD_DATETIME=!returnDateTimestampCurrentZZZ!"
ECHO VMD_DATETIME="!VMD_DATETIME!"

REM ###################################################################
REM DEN HOST RECHNERNAMEN AN DIE LOG DATEIEN ANHAENGEN, dieser wurde schon per aufrufender Batch gesetzt. 
::Das ist ein anderer als der computername und ist auf dem Hostrechner selbst leer, d.h. es gibt ihn nur für einen VMWare client
ECHO HOST ist '%HOST%'
IF NOT "%HOST%"=="" (
    ECHO Batch wird in einer VM, auf einem Host ausgefuehrt.
	set "VMD_HOST=%HOST%_"
   ) ELSE (
	ECHO Batch wird auf dem Host selber und nicht in einer VM ausgefuehrt.
    set "VMD_HOST="
   )


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
	
REM Beobachtung... Bei einem Fehler im Ant-Script wird sowohl errorlevel 0 als auch errorlevel 1 gesetzt
if errorlevel 0 (
	echo.errorlevel 0
) else (
	echo.errorlevel ist nicht 0
)	
REM Beobachtung... Errorlevel 1 wird bei einem Fehler im ant-Script gesetzt.
if errorlevel 1 (
	echo.errorlevel 1
) else (
	echo.errorlevel ist nicht 1
)
	
REM Dokumentiere jeden Lauf, ausser im Testfall. Kopiere dazu das Log in eine Datei mit dem aktuellen Timestamp.
REM Solange wie noch nicht gewünscht wird diese Logs im Repository zu archivieren, werden sie in ein temp - Verzeichnis kopiert.
:: Diese Umgebungsvariable wird im Ant-Script gesetzt. Dieser Wert wird in der project_RECHNERNAME_vmd.properties Datei gesetzt
:: und im Ant-Script ausgelesen.
REM SET "VMD_OPERATION_MODE=PROD (kann_fuer_Test_gesetzt_werden_in_'project_%COMPUTERNAME%_%VMD_HOST%vmd.properties'_auf_'test')"
echo.VMD_OPERATION_MODE='%VMD_OPERATION_MODE%'
IF "%VMD_OPERATION_MODE%"=="test" (
	echo."Testmodus. Protokolliere den Lauf nicht."
) ELSE (
	IF "%VMD_OPERATION_MODE%"=="" (
	    REM Hinweismeldung. Beachte, dass dies in Hochkommata gesetzt wird, weil darin Klammern verwendet werden.
		echo."Prodmodus (Modus kann gesetzt werden in 'project_%COMPUTERNAME%_%VMD_HOST%vmd.properties'. Z.B. für auf 'test' damit die Testkonfiguration test_vmd.properties verwendet wird.)"
	) 
    md c:\temp 2> NUL
	md c:\temp\Projekt_VMD 2> NUL
	md c:\temp\Projekt_VMD\log 2> NUL
	COPY C:\1fgl\repository\Projekt_VMD\log\log.txt C:\temp\Projekt_VMD\log\log%VMD_HOST%%COMPUTERNAME%_%VMD_DATETIME%.txt
	COPY C:\1fgl\repository\Projekt_VMD\log\error.txt C:\temp\Projekt_VMD\log\error%VMD_HOST%%COMPUTERNAME%_%VMD_DATETIME%.txt
) 

REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
ENDLOCAL
ENDLOCAL

REM timeout /T 20 /nobreak
REM nicht im Debuggen, sonst wieder einkommentieren, damit sich das Fenster schliesst: exit
echo Ende Copy Repository to Local HOST
pause

REM Ohne diesen Labelaufruf werden die Unterlabels erneut aufgerufen...
goto:eof

REM ##################    UNTERFUNKTIONEN #################################################
:StringLength
REM  returns the length of a string
::              -- returnStringLength    [out] - variable to be used to return the string length
::              -- string [in]  - variable name containing the string being measured for length
(   
    SETLOCAL
	REM echo.in StringLength r="%1"
	REM echo.in StringLength s="%2"	
	REM warum geht das nicht set "s=!%~2!#"	
	set "s=%2#"	
	REM echo.in StringLength02 s="!s!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	REM echo.in StringLength03 s nach Ersetzung="!s!"
	
    set "returnStringLength=0"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
       if "!s:~%%P,1!" NEQ "" ( 
            set /a "returnStringLength+=%%P"
            set "s=!s:~%%P!"
        )
    )
)
( 
  ENDLOCAL & REM RETURN VALUES
  ::echo.%returnStringLength%
  set "%~1=%returnStringLength%"
  exit /b
)
GOTO:EOF

:StringLengthZZZ
REM  returns the length of a string (Reihenfolge der Argumente vertauscht gegenüber :StringLength)
::              -- string [in]  - variable name containing the string being measured for length
::              -- len    [out] - variable to be used to return the string length
(   
    SETLOCAL
	REM echo.in StringLengthZZZ r="%2"
	REM echo.in StringLengthZZZ s="%1"
	
	set "s=!%~1!#"	
	REM echo.in StringLength02 s="!s!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	REM echo.in StringLength03 s nach Ersetzung="!s!"
	
    set "returnStringLengthZZZ=0"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
       if "!s:~%%P,1!" NEQ "" ( 
           set /a "returnStringLengthZZZ+=%%P"
           set "s=!s:~%%P!"
      )
    )
)
( 
  ENDLOCAL & REM RETURN VALUES
  ::echo.%returnStringLengthZZZ%
  set "%~2=%returnStringLengthZZZ%"
  exit /b
  )
GOTO:EOF

:StringLeftInclude
(   
    SETLOCAL
	
   REM Originalcode:
   REM set "find=* "
   REM call set sTempDelete=%%myTime:!find!=%%
   REM echo sTempDelete="!sTempDelete!"
   REM call set myTime=%%myTime:!sTempDelete!=%%
   REM echo myTime ohne Millisekunden="!myTime!"
   
   REM "Wird ein String mit Leerzeichen übergeben, so werden die Leerzeichen implizit als Trenner der Übergabeparameter interpretiert".
   REM Daher sollte ein String vorher "encoded" werden.
   REM echo.Start von StringLeftInclude mit String und Delimiter: "%1" und "%2"
   set "myString=%1"
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
   set myString=!myString:##FGLBLANK##= !
   REM echo.myString in StringLeftInclude="!myString!"
	
   set "myFind=%2"
   REM echo.1. myFind in StringLeftInclude="!myFind!"
   
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   if "!myFind!"=="" (
		set "myFind=##FGLBLANK##"
	) 
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myFind=!myFind:##FGLBLANK##= !
	REM echo.2a. myFind in StringLeftInclude="!myFind!"
    
   
   REM original set "myFind=*%2"
   set "myFind=*!myFind!"
   REM echo.3. myFind in StringLeftInclude="!myFind!"
	
   call set sTempDelete=%%myString:!myFind!=%%
   REM echo 3b. sTempDelete="!sTempDelete!"
   if "!sTempDelete!"=="!myString!" (
	    set "returnStringLeftInclude=!myString!"
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		REM echo Reduzierter String="!myStrReduced!"
		set "returnStringLeftInclude=!myStrReduced!"		
	)	
   REM set "myFind=*!myFind!"
   REM echo.4. myFind in StringLeftInclude="!myFind!"
   
   call set sTempDelete=%%myString:!myFind!=%%
   REM echo sTempDelete="!sTempDelete!"
   if "!sTempDelete!"=="!myString!" (
		set myStrReduced=!myString: =##FGLBLANK##!
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		REM echo Reduzierter String="!myStrReduced!"
		set myStrReduced=!myStrReduced: =##FGLBLANK##!
	)
	set "returnStringLeftInclude=!myStrReduced!"
)
   ( 
  ENDLOCAL & REM RETURN VALUES
  ::echo.%returnStringLeftInclude%
  set "%~3=%returnStringLeftInclude%"
  exit /b
  )
GOTO:EOF
   
:StringRight
(
	SETLOCAL
	REM echo.Start von StringRight mit "String" und "Anzahl Zeichen": "%1" und "%2"
	set "myStr=%1"
	set "myNumber=%2"
	set "returnStringTrimRight=%3"
		
	REM Die ##FGLBLANK## Zeichen wieder gegen Leerzeichen eintauschen
	set myStr=!myStr:##FGLBLANK##= !
	REM echo.myStr in StringTrimRight="!myStr!"
	
	Set /a myNumberNegative=-1*!myNumber!
	call set "myStrReducedTemp=%%myStr:~!myNumberNegative!%%"
	
	set myStrReducedTemp=!myStrReducedTemp: =##FGLBLANK##!
	SET "returnStringRight=!myStrReducedTemp!"
	GOTO :StringRightEnd
)
(
:StringRightEnd
	( 
    ENDLOCAL & REM RETURN VALUES
	::echo.%returnStringTrimRight%
	set "%~3=%returnStringRight%"
	exit /b
	)
)
GOTO:EOF

   
:StringTrimRight
(   
    SETLOCAL
	REM echo.Start von StringTrimRight mit: "%1"
	set "myStr=%1"
	set "returnStringTrimRight=%2"
	REM echo.myStr in StringTrimRight=!myStr!
	
	REM Der Rückgabewert, falls kein Leerstring am Ende wegzutrimmen ist
	set "myStrReduced=!myStr!"
	set "returnStringTrimRight=!myStr!"
	
	REM Hole die Länge des zu trimmenden Strings VOR DER ERSETZUNG
	set  returnStringLength=-1
	call :StringLength returnStringLength !myStr! 
	REM echo.Länge '!returnStringLength!'
	set "myStrLength=!returnStringLength!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myStr=!myStr:##FGLBLANK##= !
	REM echo.myStr nach Ersetzung in StringTrimRight="!myStr!"
		
	set /a myStrLengthNegative=-1*!myStrLength!	
	REM echo.myStringLengthNegative="!myStrLengthNegative!"
	for /l %%x in (1,1,!myStrLength!) do (		
        REM echo.letzte Buchstaben bei %%x : !myStr:~-%%x,1!		
		
		REM "Länge des Strings +1" Minus Zählvariable. Die Zählvariable startet bei 1!
		set /a itemp=!myStrLength!-%%x				
		REM echo.itemp=!itemp!
		
		REM Beachte hier die verzoegerte Berechnung zur Laufzeit durch Ausrufezeichen ....   
		set "ctemp=!myStr:~-%%x,1!"
		if "!ctemp!"==" " (
			REM echo.Leerstring gefunden, Schleife fortsetzen.
			) else (
			REM echo.Kein Leerstring, Schleife abbrechen.								
			REM echo.Zählvariable itemp=!itemp!
			REM echo.Gefundenes Zeichen "!ctemp!"
			call set "myStrReducedTemp=%%myStr:~!myStrLengthNegative!,!itemp!%%"
			REM echo.reduzierter String Temp = "!myStrReducedTemp!"
			set "myStrReduced=!myStrReducedTemp!!ctemp!"
			REM echo.reduzierter String Temp = "!myStrReducedTemp!"
			
			set "returnStringTrimRight=!myStrReduced!"
			REM echo.in StringTrimRight Ergebnis= "!returnStringTrimRight!"	
			GOTO :StringTrimRightEnd
			)
	)		
)
(	
:StringTrimRightEnd	
	( 
    ENDLOCAL & REM RETURN VALUES
	::echo.%returnStringTrimRight%
	set "%~2=%returnStringTrimRight%"
	exit /b
	)

:DateTimestampCurrentZZZ
(
 SETLOCAL

	REM echo.Start von DateTimestampCurrentZZZ mit: "%1"
	REM set "myStr=%1"
	REM echo.myStr in StringTrimRight=!myStr!

	REM Der Default Rückgabewert, falls nichts zu tun ist ist
	REM set "myStrReduced=!myStr!"
	REM set "returnStringTrimRight=!myStr!"
	set "returnDateTimestampZZZ=%1"
	set myDateTimestamp=%DATE%
	set "returnDateTimestampZZZ=!myDateTimestamp!
	
	REM  ###################################################################
	@echo off
	@REM Set ups %date variable
	@REM First parses month, day, and year into mm , dd, yyyy formats and then combines to be MMDDYYYY

	REM WIN7, deutsch...
	echo.Datum ---- Uhrzeit ist %DATE% ---- %TIME%

	REM Setze Wertzuweisung hinter dem SET - Befehl in Anführungszeichen, um zu verhindern, dass Leerzeichen am Ende der Zeile in den Variablenwert "reinrutschen"	
	For /f "tokens=1-3 delims=/." %%a in ('date /t') do (
		set "myMM=%%b"
		
		set "returnStringTrimRight="
		call :StringTrimRight %%a returnStringTrimRight
		set "myDD=!returnStringTrimRight!"
		
		REM call :trimLeft %%c
		set "returnStringTrimRight="
		call :StringTrimRight %%c returnStringTrimRight
		set "myYYYY=!returnStringTrimRight!"

	REM Bei aktivierter Befehlserweiterung wird mit /t verhindert, dass die Eingabe einer neuen Zeit (oder ENTER DRUECKEN) erfolgt.
	REM Das gibt nur Stunden und Minuten aus For /f "tokens=1-4 delims=/:" %%a in ('time /t') do (set "mytime=%%a%%b%%c")
	REM Das gibt zwar auch Sekunden aus, aber die Stundenzahl ist nicht zweistellig und die Millisekunden will ich nicht 
	REM For /f "tokens=1-4 delims=/:." %%a in ('echo %time%') do (set "mytime=%%a%%b%%c")

	REM VOR der STUNDENAUSGABE EINE FUEHRENDE 0.
	For /f "tokens=1-4 delims=/:." %%a in ('echo %time%') do (

		set "myHour=%%a"
		set "myHour=0!myHour!"	
		set "returnStringRight="
		REM ersetze Leerzeichen durch Ausdruck
		set "myHour=!myHour: =##FGLBLANK##!"
		call :StringRight !myHour! 2 returnStringRight
		REM Leerzeichen wieder einsetzen
		set "returnStringRight=!returnStringRight:##FGLBLANK##= !"
		set "myHour=!returnStringRight!"
		
		set "mytime=!myHour!%%b%%c"
		)
	REM echo !myYYYY!_!myMM!_!myDD!_!myTime!

	REM In dem 'date /t' wird die Millisekundenausgabe mit Komma abgetrennt angezeigt. Bei dem 'echo %time%' ebenfalls.
	REM Intern und programmiertechnisch muss ich hier aber auf ein Leerzeichen abbprüfen, damit der String links davon gefunden wird.

	REM Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
	REM Funktionierendes Beispiel
	REM set myTime=Das ist toll
	REM set myTime=%myTime: =_%
	REM call :StringLeftInclude !myTime! _
	REM set "myTime=!returnStringLeftInclude!"
	REM echo myTime links=!myTime!

	REM Aber wg des Leerzeichens im 'echo time' reicht schon folgendes. Grund: Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
	set "returnStringLeftInclude="
	call :StringLeftInclude !myTime! returnStringLeftInclude
	set "myTime=!returnStringLeftInclude!"

	set "returnStringTrimRight="
	call :StringTrimRight !myTime! returnStringTrimRight
	set "myTime=!returnStringTrimRight!"

	set "myDateTimestamp=!myYYYY!!myMM!!myDD!_!myTime!"
	
	REM  ###################################################################
	set "returnDateTimestampCurrentZZZ=!myDateTimestamp!"
	REM echo.in DateTimestampCurrent Ergebnis= "!returnDateTimestampCurrentZZZ!"
	GOTO :DateTimestampCurrentZZZEnd
)
:DateTimestampCurrentZZZEnd
(
	ENDLOCAL & REM RETURN VALUES
	set "%~1=%returnDateTimestampCurrentZZZ%"
	exit /b
)


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

REM ECHO Versionsnummer: %VersionNumber%
::ECHO VersionMajor.VersionMinor.VersionBuild: %VersionMajor%.%VersionMinor%.%VersionBuild%
::ECHO VersionName: %VersionName%
::ECHO VMD_OS Kuerzel (errechnet): %returnMachineLocalOs%

GOTO :MachineLocalOsZZZEnd
:MachineLocalOsZZZEnd
(
  ENDLOCAL & REM RETURN VALUES
  ::echo.%returnMachineLocalOs%
  set "%~1=%returnMachineLocalOs%"
  exit /b
)
GOTO:EOF