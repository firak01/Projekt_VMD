REM nicht mit dem Wait befehl arbeiten, da das Konsolenfenster der neuen Batch sich nicht schliesst start /wait .\Domino\ServerDominoQuit.bat 
REM ausser die Batch schliesst explizit das konsolenfenster mit einem exit befehl
REM ABER: Wenn der server nicht mehr läuft, dann kann die konsole nix mehr entgegennehmen. Darum nicht verwenden:
REM start /wait .\Domino\ServerDominoQuit.bat 

REM die Batchparameter z.B. host= werden per #* entgegengenommen und an das ANT-Script per -D%* weitergereicht.
REM Im AntScript stehen sie dann als Property zur Verfügung. Z.B. <property name="host" value="nothing"/><echo message="Wert fuer host= ${host}"/>
start .\"2_VmdByFGL_copyLocal2Repository_HOST.bat" host=UGAKI-SRV

REM das konsolenfenster schliessen. Was wichtig ist, falls ein aufrufendes Programm auf das ende des Batch-Tasks wartet.
exit