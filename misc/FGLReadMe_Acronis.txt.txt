
---------------------------------------------------------
Probleme wg. "Abbruch wg. Zeit�berschreitung"

Man kann oben rechts im Backup/Recovery Men� die Zeit f�r diesen Wert einstellen.
Damit ist gemeint, wie lange Acronis auf Antwort bei Anwenderdialogen warten soll.
Beispielsweise, wenn eine USB - Festplatte nicht erreichbar ist, kann der Anwender auf "wiederholen" clicken
und dann funktioniert es.

----------------------------------------------------------
Probleme wg. des UEFI-BIOS.

Erfolgreich clonen kann man mit Acronis True Image 2013 so:
Backup unter Windows starten. Sektorweise kopieren. (Das dauert richtig lange).

Zum Clonen mit der bootbaren Acronis CD den Rechner booten.
Im Acronis Tool das zuvor erstellte Backup ausw�hlen.

    Davon dann die 100MB Partition (soll wohl UEFI sein) ausw�hlen und die Windows Partition.

    NICHT aber den MBR.

Backup zur�ckspielen, 
ggf. vorher alles auf dem Laufwerk l�schen (dauert beides richtig lange), z.B. auch ein zuvor angelegten MBR.

