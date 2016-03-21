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
echo.TESTS: Zur Ermittlung des aktuellen Timestamps
echo.###################################################################
echo.TESTS FUER DateTimestampCurrentZZZ
set  "returnDateTimestampCurrentZZZ="

REM Anders als im Original aus dem Web, habe ich die Reihenfolge der Argumente vertauscht.
call :DateTimestampCurrentZZZ returnDateTimestampCurrentZZZ 
echo.Ergebnis="%returnDateTimestampCurrentZZZ%"

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
:StringLength
REM  returns the length of a string
::              -- returnStringLength    [out] - variable to be used to return the string length
::              -- string [in]  - variable name containing the string being measured for length
(   
    SETLOCAL
	REM echo.in StringLength r="%1"
	::echo.in StringLength s="%2"	
	REM warum geht das nicht set "s=!%~2!#"	
	set "s=%2#"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	
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
	
	set "s=!%~1!#"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	
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
   set "myString=%1"
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
   set myString=!myString:##FGLBLANK##= !
   REM echo.myString in StringLeftInclude="!myString!"
	
   set "myFind=%2"
   
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   if "!myFind!"=="" (
		set "myFind=##FGLBLANK##"
	) 
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myFind=!myFind:##FGLBLANK##= !
    
   
   REM original set "myFind=*%2"
    set "myFind=*!myFind!"
	
   call set sTempDelete=%%myString:!myFind!=%%
   if "!sTempDelete!"=="!myString!" (
	    set "returnStringLeftInclude=!myString!"
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		echo Reduzierter String="!myStrReduced!"
		set "returnStringLeftInclude=!myStrReduced!"
	)	
   REM set "myFind=*!myFind!"
   
   call set sTempDelete=%%myString:!myFind!=%%
   if "!sTempDelete!"=="!myString!" (
		set myStrReduced=!myString: =##FGLBLANK##!
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		set myStrReduced=!myStrReduced: =##FGLBLANK##!
	)
	set "returnStringLeftInclude=!myStrReduced!"
)
   ( 
  ENDLOCAL & REM RETURN VALUES
  set "%~3=%returnStringLeftInclude%"
  exit /b
  )
GOTO:EOF

REM Beispiel für "Zeichen von rechts abschneiden"
REM set str=politic
REM echo.%str%
REM set str=%str:~-4%
REM echo.%str%
:StringRight
(
	SETLOCAL
	REM echo.Start von StringRight mit "String" und "Anzahl Zeichen": "%1" und "%2"
	set "myStr=%1"
	set "myNumber=%2"
	set "returnStringTrimRight=%3"
		
	REM Die ##FGLBLANK## Zeichen wieder gegen Leerzeichen eintauschen
	set myStr=!myStr:##FGLBLANK##= !
	
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
	
	REM Der Rückgabewert, falls kein Leerstring am Ende wegzutrimmen ist
	set "myStrReduced=!myStr!"
	set "returnStringTrimRight=!myStr!"
	
	REM Hole die Länge des zu trimmenden Strings VOR DER ERSETZUNG
	set  returnStringLength=-1
	call :StringLength returnStringLength !myStr!
	set "myStrLength=!returnStringLength!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myStr=!myStr:##FGLBLANK##= !
	set /a myStrLengthNegative=-1*!myStrLength!	
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
			GOTO :StringTrimRightEnd
			)
	)		
)
(	
:StringTrimRightEnd	
	( 
    ENDLOCAL & REM RETURN VALUES
	set "%~2=%returnStringTrimRight%"
	exit /b
	)
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
	echo.in DateTimestampCurrent Ergebnis= "!returnDateTimestampCurrentZZZ!"
	GOTO :DateTimestampCurrentZZZEnd
)
:DateTimestampCurrentZZZEnd
(
	ENDLOCAL & REM RETURN VALUES
	set "%~1=%returnDateTimestampCurrentZZZ%"
	exit /b
)

GOTO:EOF

	