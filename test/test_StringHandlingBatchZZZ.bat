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
echo.TESTS: Zur Ermittlung der Stringlaenge
echo.###################################################################
echo.TESTS FUER STRINGLENGTHZZZ
set "myStr=36haractersForLength mit Leerzeichen"
set  returnStringLengthZZZ=-1

REM Anders als im Original aus dem Web, habe ich die Reihenfolge der Argumente vertauscht.
call :StringLengthZZZ myStr returnStringLengthZZZ 
echo.Ergebnis="%returnStringLengthZZZ%"

echo.	
echo.###################################################################
echo.TESTS FUER STRINGLENGTH
set "myStr=27ForLength mit Leerzeichen"
set  returnStringLength=-1

REM Anders als im Original aus dem Web, habe ich die Reihenfolge der Argumente vertauscht.
call :StringLength returnStringLength myStr
echo.Ergebnis="%returnStringLength%"


echo.	
echo.###################################################################
echo.TESTS FUER STRINGRIGHT
echo.###################################################################
echo.TEST: StringRight ... statischer Text, direktes ausfuehren, d.h. ohne Aufruf einer Unterfunktion.
set "str=Zum Abschneiden 9 Zeichen"
REM Originalcode, gedacht zum Ausführen ohne Aufruf einer Unterfunktion.
echo."%str%"
set str=%str:~-9%
echo."%str%"

echo. 
echo.###################################################################
echo.TEST: StringRight ... statischer Text, mit Aufruf einer Unterfunktion.
set "str=Zum Abschneiden 9 Zeichen"

set "returnStringRight="
REM ersetze Leerzeichen durch Ausdruck
set "str=%str: =##FGLBLANK##%"
call :StringRight %str% 9 returnStringRight
REM Leerzeichen wieder einsetzen
set "returnStringRight=!returnStringRight:##FGLBLANK##= !"
echo.Ergebnis StringRight="!returnStringRight!"

echo.	
echo.###################################################################
echo.TESTS FUER STRINGTRIMRIGHT
echo.###################################################################
echo.TEST: StringTrimRight ... statischer Text, direktes ausfuehren, d.h. ohne Aufruf einer Unterfunktion.
set "str=15a Trailing Spaces to truncate.  Lenght 58               "
REM Originalcode, gedacht zum Ausführen ohne Aufruf einer Unterfunktion.
echo."%str%"
for /l %%a in (1,1,31) do if "!str:~-1!"==" " set str=!str:~0,-1!
echo."%str%"


echo. 
echo.###################################################################
echo.TEST: StringTrimRight ... statischer Text, mit Aufruf einer Unterfunktion.
REM Leerzeichen werden als Trenner für weitere Argumente an die Funktion gewertet, darum durch Unterstrich ersetzen
set "str=15b Trailing Spaces to truncate.  Lenght 58               "
REM ersetze Leerzeichen durch Unterstriche
set str=%str: =##FGLBLANK##%
echo."%str%"

set "returnStringTrimRight="
call :StringTrimRight %str% returnStringTrimRight
echo.Ergebnis von StringTrimRight "!returnStringTrimRight!"
set "str=!returnStringTrimRight!"	
echo.Ergebnis von StringTrimRight uebertragen "!str!"
echo. 
echo.###################################################################
echo.TEST: StringTrimRight ... dynamischer Text (hier Datum), mit Aufruf einer Unterfunktion.

REM Ermittle auf Batch Ebene einen Timestamp, dieser dient zuerst zur Benennung der Log-Dateien, ist aber auch im Script auslesbar.
@REM Set ups %date variable
@REM First parses month, day, and year into mm , dd, yyyy formats and then combines to be MMDDYYYY

REM echo . schaltet das ausgeschaltete Echo wieder für diese zeile ein. 
echo.Datum ist %DATE%

REM Setze Wertzuweisung hinter dem SET - Befehl in Anführungszeichen, um zu verhindern, dass Leerzeichen am Ende der Zeile in den Variablenwert "reinrutschen"
REM WIN7, deutsch...
For /f "tokens=1-3 delims=/." %%a in ('date /t') do (
    set "myMM=%%b"
	
	call :StringTrimRight %%a returnStringTrimRight
	set "myDD=!returnStringTrimRight!"
	
	call :StringTrimRight %%c	returnStringTrimRight
	set "myYYYY=!returnStringTrimRight!"	
	)

echo !myYYYY!_!myMM!_!myDD!	
echo. 
echo.###################################################################
echo.TEST: StringLeftInclude ... statischer Text, mit Aufruf einer Unterfunktion.
REM set "myText=das##FGLBLANK##ist##FGLBLANK##toll"
set "myText=das ist toll"
echo.Text ist: "!myText!"

REM ersetze Leerzeichen durch Unterstriche
REM Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
set myText=%myText: =##FGLBLANK##%
echo.myText=!myText!
::set "myFind=##FGLBLANK##"
set "myFind=ist"

REM Aber wg des Leerzeichens im 'echo time' reicht schon folgendes. Grund: Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
REM call :StringLeftInclude !myTime! 
set "returnStringLeftInclude="
call :StringLeftInclude !myText! !myFind! returnStringLeftInclude
set "myText=!returnStringLeftInclude!"
echo.myText links="!myText!"
echo.

echo.###################################################################
echo.TEST: StringLeftInclude ... dynamischer Text (hier Datum), mit Aufruf einer Unterfunktion.
echo.Zeit ist %TIME%
	
REM Bei aktivierter Befehlserweiterung wird mit /t verhindert, dass die Eingabe einer neuen Zeit (oder ENTER DRUECKEN) erfolgt.
REM Das gibt nur Stunden und Minuten aus For /f "tokens=1-4 delims=/:" %%a in ('time /t') do (set "mytime=%%a%%b%%c")
REM Das gibt zwar auch Sekunden aus, aber die Stundenzahl ist nicht zweistellig und die Millisekunden will ich nicht 

For /f "tokens=1-4 delims=/:." %%a in ('echo %time%') do (set "mytime=%%a%%b%%c")
echo.1. myTime=!myTime!

REM ersetze Leerzeichen durch Unterstriche
REM Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
set myTime=%myTime: =##FGLBLANK##%
echo.2. myTime=!myTime!

REM In dem 'date /t' wird die Millisekundenausgabe mit Komma abgetrennt angezeigt. Bei dem 'echo %time%' ebenfalls.
REM Intern und programmiertechnisch muss ich hier aber auf ein Leerzeichen abbprüfen, damit der String links davon gefunden wird.

REM Aber wg des Leerzeichens im 'echo time' reicht schon folgendes. Grund: Wenn ein Leerzeichen in dem Übergabestring ist, wir das als Trenner der an die Funktion übergebenen Argumente angesehen
REM call :StringLeftInclude !myTime! 
set "returnStringLeftInclude="
call :StringLeftInclude !myTime! ##FGLBLANK## returnStringLeftInclude
set "myTime=!returnStringLeftInclude!" 
echo.myTime links=!myTime!

set "returnStringTrimRight="
call :StringTrimRight !myTime! returnStringTrimRight
set "myTime=!returnStringTrimRight!"



set "VMD_DATETIME=!myYYYY!!myMM!!myDD!_!myTime!"
ECHO.VMD_DATETIME="!VMD_DATETIME!"

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
	echo.in StringLength r="%1"
	echo.in StringLength s="%2"	
	REM warum geht das nicht set "s=!%~2!#"	
	set "s=%2#"	
	echo.in StringLength02 s="!s!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	echo.in StringLength03 s nach Ersetzung="!s!"
	
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
  echo.%returnStringLength%
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
	echo.in StringLengthZZZ r="%2"
	echo.in StringLengthZZZ s="%1"
	
	set "s=!%~1!#"	
	echo.in StringLength02 s="!s!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set s=!s:##FGLBLANK##= !
	echo.in StringLength03 s nach Ersetzung="!s!"
	
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
  echo.%returnStringLengthZZZ%
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
   echo.Start von StringLeftInclude mit String und Delimiter: "%1" und "%2"
   set "myString=%1"
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
   set myString=!myString:##FGLBLANK##= !
   REM 
   echo.myString in StringLeftInclude="!myString!"
	
   set "myFind=%2"
   echo.1. myFind in StringLeftInclude="!myFind!"
   
   REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
   REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
   if "!myFind!"=="" (
		set "myFind=##FGLBLANK##"
	) 
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myFind=!myFind:##FGLBLANK##= !
	echo.2a. myFind in StringLeftInclude="!myFind!"
    
   
   REM original set "myFind=*%2"
    set "myFind=*!myFind!"
   echo.3. myFind in StringLeftInclude="!myFind!"
	
   call set sTempDelete=%%myString:!myFind!=%%
   echo 3b. sTempDelete="!sTempDelete!"
   if "!sTempDelete!"=="!myString!" (
	    set "returnStringLeftInclude=!myString!"
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		echo Reduzierter String="!myStrReduced!"
		set "returnStringLeftInclude=!myStrReduced!"		
	)	
   REM set "myFind=*!myFind!"
   echo.4. myFind in StringLeftInclude="!myFind!"
   
   call set sTempDelete=%%myString:!myFind!=%%
   echo sTempDelete="!sTempDelete!"
   if "!sTempDelete!"=="!myString!" (
		set myStrReduced=!myString: =##FGLBLANK##!
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		echo Reduzierter String="!myStrReduced!"
		set myStrReduced=!myStrReduced: =##FGLBLANK##!
	)
	set "returnStringLeftInclude=!myStrReduced!"
)
   ( 
  ENDLOCAL & REM RETURN VALUES
  echo.%returnStringLeftInclude%
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
	REM 
	echo.Start von StringRight mit "String" und "Anzahl Zeichen": "%1" und "%2"
	set "myStr=%1"
	set "myNumber=%2"
	set "returnStringTrimRight=%3"
		
	REM Die ##FGLBLANK## Zeichen wieder gegen Leerzeichen eintauschen
	set myStr=!myStr:##FGLBLANK##= !
	echo.myStr in StringTrimRight="!myStr!"
	
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
	REM 
	echo.Start von StringTrimRight mit: "%1"
	set "myStr=%1"
	set "returnStringTrimRight=%2"
	echo.myStr in StringTrimRight=!myStr!
	
	REM Der Rückgabewert, falls kein Leerstring am Ende wegzutrimmen ist
	set "myStrReduced=!myStr!"
	set "returnStringTrimRight=!myStr!"
	
	REM Hole die Länge des zu trimmenden Strings VOR DER ERSETZUNG
	set  returnStringLength=-1
	call :StringLength returnStringLength !myStr! 
	echo.Länge '!returnStringLength!'
	set "myStrLength=!returnStringLength!"
	
	REM Leerzeichen in einem String werden als Argumenttrenner für diesen Funktionsaufruf angesehen.
	REM Darum müssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die Rückübersetzung.
	REM Greift nicht auf die lokale Variable zu set myStr=%myStr:##FGLBLANK##= %
	set myStr=!myStr:##FGLBLANK##= !
	REM 
	echo.myStr nach Ersetzung in StringTrimRight="!myStr!"
		
	set /a myStrLengthNegative=-1*!myStrLength!	
	REM 
	echo.myStringLengthNegative="!myStrLengthNegative!"
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
			echo.in StringTrimRight Ergebnis= "!returnStringTrimRight!"	
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
)
GOTO:EOF

	