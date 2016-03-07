@echo off
REM @ECHO off schaltet das echo aus... . KONVERTIERE DIESE DATEI ZU ANSI, NUR DANN WIRD '@echo off' als Befehl erkannt.
REM echo. schaltet das echo f�r diese eine Zeile wieder ein.

REM Zur verz�gerten �bersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit �bersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verz�gerter �bersetzung voraus)
REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION


REM ###################################################################
REM Allgemeine Hinweise f�r die Batch Programmierung
REM 
	REM In Anf�hrungszeichen z.B. !theVariable!
	REM Zur verz�gerten �bersetzung von Variablen. Bewirkt, dass die Variable nicht zur Kompilierzeit sondern erst zur Laufzeit �bersetzt wird (setzt die Verwendung von SETLOCAL zur Aktivierung von verz�gerter �bersetzung voraus)	

REM zur Schleife:
	REM Die Variable darf nur aus einem Buchstaben bestehen! "%t" ist erlaubt, "%test" nicht! Bei der Verwendung mehrerer Befehle muss zwischen "DO" und der Klammer "(" ein Leerzeichen sein.
	REM so w�rde eine Schleife r�ckw�rts gez�hlt for /l %%x in (10,-1,1) do (
	REM was bedeuted das /l. Es muss etwas listenm��iges sein und ist wichtig?.... 
		REM L�sung: Mit solchen Schleifen kann man Aktionen eine bestimmte Anzahl oft ausf�hren. Dazu muss man den Parameter /L angeben.
		REM Beispiel wenn in :timRight staende: for %%x in (2,1,341) do ( w�rde wegen fehlendem /l nur einmal ausgef�hrt
	
REM Zum if - Befehl
	REM Der Parameter /i unterbindet eine Differenzierung der Gro�-/Kleinbuchstaben.
	REM Bei der Verwendung mehrerer Befehle muss zwischen Bedingung und der Klammer "(" ein Leerzeichen sein.
	
REM Zum set - Befehl, d.h. zu Variablen:
	REM Der Parameter /a 
		REM wird dazu verwendet Rechenoperationen durchzuf�hren
		
	REM zum Ausrufezeichen
		REM Definiert eine Variable, zur Verz�gerten Berechenung, d.h. erst zur Laufzeit berechnen. Siehe SETLOCAL ENABLEDELAYEDEXPANSION.
		
	REM Dagegen wird mit % 
		REM eine Variable wohl schon beim kompilieren berechnet.
		
	REM TIP: 
		REM Setze die Wertzuweisung hinter sem SET in Anf�hrungszeichen, damit soll verhindert werden, dass unbeabsichtigte Leerzeichen am Ende der Zeiel in den Wert rutschen.
		REM Das ist bei mathematischen SET Rechenoperationen nicht notwendig
	
REM Zum Goto:EOF Befehl
	REM Das entspricht einem Return in einer normalen Script-/Programmiersprache.
	
REM Einige Grundlagenexperimente zur Stringverarbeitung, die funktionieren
	REM set myStr="a b c d ef "		
	REM echo.myStr am Anfang="%myStr%"
	REM echo.mit Tilde -3 ist ... der drittletzte Buchstabe von date "%date:~-3,1%"
	REM echo.mit Tilde -3 sind ... die beiden (Achtung Logik) drittletzten Buchstabe von date "%date:~-3,2%"
	
	REM echo.mystring mit Tilde 0 ist alles !myStr:~0!
	REM echo.mystring mit Tilde -2,1 ist ... der letzte Buchstabe "!myStr:~-2,1!"
	REM echo.mystring mit Tilde -3,1 ist ... der vorletzte Buchstabe "!myStr:~-3,1!"
	REM echo.mystring mit Tilde -3,2 ist ... der vorletzte und letzte Buchstabe "!myStr:~-3,2!"
	

REM PROBLEM: In einer Schleife dynamisch eine Variable einf�gen. Wie ich diese Formel entwickelt habe: call set "myStrReduced=%%myStr:~-32,!itemp!%%"
REM https://www.administrator.de/wissen/arbeite-batch-umgebungsvariablen-erstellung-umgang-erweiterungen-ver%C3%A4nderungen-117069.html			
			
			REM Wie rechnet man das zur Laufzeit aus... set myStrReduced="!myStr!:~-12,!itemp!"
			REM Nicht funktionierendes:
			REM set myStrReduced=!myStr!:~-12,!itemp!
			REM set myStrReduced=!myStr:~-12,itemp!
			REM set myStrReduced=!%myStr%:~-12,%itemp%!
			REM set myStrReduced=!!myStr!:~-12,!itemp!!
			REM funktioniert echo.andere Syntax %myStr:~-12,4%
			REM funktioniert aber nicht nicht echo.kombinations-syntax %myStr:~-12,!itemp!%
			
			REM nein set myStrReduced=%!myStr!:~-12,!itemp!%
			REM nein call set myStrReduced=%%!myStr!:~-12,9%			
			REM Loesung   call set "myStrReduced=%%myStr:~-32,!itemp!%%"
			REM echo.reduzierter String "!myStrReduced!"
							

	REM Beispiele, die bei der L�sungsfindung geholfen haben:
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

REM CALL
REM Wenn ein Leerzeichen in dem �bergabestring ist, wir das als Trenner der an die Funktion �bergebenen Argumente angesehen
	REM Funktionierendes Beispiel:
	REM set myTime=Das ist toll
	REM set myTime=%myTime: =_%
	REM call :StringLeftInclude !myTime! _
	REM set "myTime=!returnStringLeftInclude!"
	REM echo myTime links=!myTime!

REM ###################################################################
echo.TESTS FUER TRIMRIGHT

REM Originalcode, gedacht zum Ausf�hren ohne Aufruf einer Unterfunktion.
echo.###################################################################
echo.TEST: trimRight ... statischer Text, direktes ausfuehren, d.h. ohne Aufruf einer Unterfunktion.
set str=15 Trailing Spaces to truncate               &rem
echo."%str%"
for /l %%a in (1,1,31) do if "!str:~-1!"==" " set str=!str:~0,-1!
echo."%str%"
echo. 
echo.###################################################################
echo.TEST: trimRight ... statischer Text, mit Aufruf einer Unterfunktion.
REM Leerzeichen werden als Trenner f�r weitere Argumente an die Funktion gewertet, darum durch Unterstrich ersetzen

REM set str=15 Trailing Spaces to truncate               &rem
REM ersetze Leerzeichen durch Unterstriche
set str=%str: =##FGLBLANK##%
echo."%str%"

REM set str=15_Trailing_Spaces_to_truncate               &rem
call :trimRight %str%
set "str=!returnStringTrim!"	
echo."%str%"
echo. 
echo.###################################################################
echo.TEST: trimRight ... dynamischer Text (hier Datum), mit Aufruf einer Unterfunktion.

REM Ermittle auf Batch Ebene einen Timestamp, dieser dient zuerst zur Benennung der Log-Dateien, ist aber auch im Script auslesbar.
@REM Set ups %date variable
@REM First parses month, day, and year into mm , dd, yyyy formats and then combines to be MMDDYYYY

REM echo . schaltet das ausgeschaltete Echo wieder f�r diese zeile ein. 
echo.Datum ist %DATE%

REM Setze Wertzuweisung hinter dem SET - Befehl in Anf�hrungszeichen, um zu verhindern, dass Leerzeichen am Ende der Zeile in den Variablenwert "reinrutschen"
REM WIN7, deutsch...
For /f "tokens=1-3 delims=/." %%a in ('date /t') do (
    set "myMM=%%b"
	
	call :trimRight %%a
	set "myDD=!returnStringTrim!"
	
	call :trimRight %%c	
	set "myYYYY=!returnStringTrim!"	
	)

echo !myYYYY!_!myMM!_!myDD!	
echo. 
echo.###################################################################
echo.TEST: StringLeftInclude ... statischer Text, mit Aufruf einer Unterfunktion.
REM set "myText=das##FGLBLANK##ist##FGLBLANK##toll"
set "myText=das ist toll"
echo.Text ist: "!myText!"

REM ersetze Leerzeichen durch Unterstriche
REM Wenn ein Leerzeichen in dem �bergabestring ist, wir das als Trenner der an die Funktion �bergebenen Argumente angesehen
set myText=%myText: =##FGLBLANK##%
echo.myText=!myText!
set "myFind=##FGLBLANK##"

REM Aber wg des Leerzeichens im 'echo time' reicht schon folgendes. Grund: Wenn ein Leerzeichen in dem �bergabestring ist, wir das als Trenner der an die Funktion �bergebenen Argumente angesehen
REM call :StringLeftInclude !myTime! 
call :StringLeftInclude !myText! !myFind!
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
REM Wenn ein Leerzeichen in dem �bergabestring ist, wir das als Trenner der an die Funktion �bergebenen Argumente angesehen
set myTime=%myTime: =##FGLBLANK##%
echo.2. myTime=!myTime!

REM In dem 'date /t' wird die Millisekundenausgabe mit Komma abgetrennt angezeigt. Bei dem 'echo %time%' ebenfalls.
REM Intern und programmiertechnisch muss ich hier aber auf ein Leerzeichen abbpr�fen, damit der String links davon gefunden wird.

REM Aber wg des Leerzeichens im 'echo time' reicht schon folgendes. Grund: Wenn ein Leerzeichen in dem �bergabestring ist, wir das als Trenner der an die Funktion �bergebenen Argumente angesehen
REM call :StringLeftInclude !myTime! 
call :StringLeftInclude !myTime! ##FGLBLANK##
set "myTime=!returnStringLeftInclude!"
echo.myTime links=!myTime!

call :trimRight !myTime!
set "myTime=!returnStringTrim!"



set "VMD_DATETIME=!myYYYY!!myMM!!myDD!_!myTime!"
ECHO.VMD_DATETIME="!VMD_DATETIME!"

REM zu jedem SETLOCAL muss es ein endlocal geben, damit das funktioniert
REM So w�rden lokale Variablen global gemacht, theoretisch, nutze ich noch nicht.
REM ENDLOCAL & set returnStringTrim=%myTest%
REM ENDLOCAL & set returnStringTrim=!myTest!
REM ENDLOCAL & set "returnStringTrim=!myStrReduced!"
ENDLOCAL
ENDLOCAL

REM Ohne diesen Labelaufruf werden die Unterlabels erneut aufgerufen...
GOTO:EOF

:StringLeftInclude
   REM Originalcode:
   REM set "find=* "
   REM call set sTempDelete=%%myTime:!find!=%%
   REM echo sTempDelete="!sTempDelete!"
   REM call set myTime=%%myTime:!sTempDelete!=%%
   REM echo myTime ohne Millisekunden="!myTime!"
   
   REM "Wird ein String mit Leerzeichen �bergeben, so werden die Leerzeichen implizit als Trenner der �bergabeparameter interpretiert".
   REM Daher sollte ein String vorher "encoded" werden.
   echo.Start von StringLeftInclude mit String und Delimiter: "%1" und "%2"
   set "myString=%1"
   REM Leerzeichen in einem String werden als Argumenttrenner f�r diesen Funktionsaufruf angesehen.
   REM Darum m�ssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die R�ck�bersetzung.
   set myString=%myString:##FGLBLANK##= %
   REM echo.myString in StringLeftInclude="!myString!"
	
   set "myFind=%2"
   echo.1. myFind in StringLeftInclude="!myFind!"
   
   REM Leerzeichen in einem String werden als Argumenttrenner f�r diesen Funktionsaufruf angesehen.
   REM Darum m�ssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die R�ck�bersetzung.
   if "!myFind!"=="" (
		set myFind=##FGLBLANK##
	) else (		
		set myFind=%myFind:##FGLBLANK##= %
	)
	echo.2. myFind in StringLeftInclude="!myFind!"
   
   set "myFind=*!myFind!"
   REM original set "myFind=*%2"
   echo.3. myFind in StringLeftInclude="!myFind!"
	
   call set sTempDelete=%%myString:!myFind!=%%
   echo sTempDelete="!sTempDelete!"
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
	    set "returnStringLeftInclude=!myString!"
	) else (
		call set myStrReduced=%%myString:!sTempDelete!=%%
		echo Reduzierter String="!myStrReduced!"
		set "returnStringLeftInclude=!myStrReduced!"
	)
   GOTO:EOF

:trimRight
	REM echo.Start von trimRight mit: "%1"
	set "myStr=%1"
	
	REM Leerzeichen in einem String werden als Argumenttrenner f�r diesen Funktionsaufruf angesehen.
	REM Darum m�ssen die Leerzeichen vorher durch einen String ersetzt werden und an dieser Stelle erfolgt die R�ck�bersetzung.
	set myStr=%myStr:##FGLBLANK##= %
	REM echo.myStr in trimRight="!myStr!"
	
	REM TODO: Hole die L�nge des zu trimmenden Strings
	set myStrLength=128
	set /a myStrLengthNegative=-1*!myStrLength!	
	for /l %%x in (1,1,!myStrLength!) do (		
        REM echo.letzte Buchstaben bei %%x : !myStr:~-%%x,1!		
		
		REM "L�nge des Strings +1" Minus Z�hlvariable. Die Z�hlvariable startet bei 1!
		set /a itemp=!myStrLength!-%%x				
		REM echo.itemp=!itemp!
		
		REM Beachte hier die verzoegerte Berechnung zur Laufzeit durch Ausrufezeichen ....   
		set ctemp=!myStr:~-%%x,1!
		REM echo.!ctemp!
		if "!ctemp!"==" " (
			REM echo Leerstring gefunden, Schleife fortsetzen.
			) else (
			REM echo kein Leerstring, Schleife abbrechen.								
			call set "myStrReduced=%%myStr:~!myStrLengthNegative!,!itemp!%%"
			REM echo.reduzierter String "!myStrReduced!"
			set "returnStringTrim=!myStrReduced!"
			GOTO:EOF
			)		
	)
	set "returnStringTrim="			
	GOTO:EOF