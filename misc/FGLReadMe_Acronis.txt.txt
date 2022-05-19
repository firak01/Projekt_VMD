
---------------------------------------------------------
Probleme wg. "Abbruch wg. Zeitüberschreitung"

Man kann oben rechts im Backup/Recovery Menü die Zeit für diesen Wert einstellen.
Damit ist gemeint, wie lange Acronis auf Antwort bei Anwenderdialogen warten soll.
Beispielsweise, wenn eine USB - Festplatte nicht erreichbar ist, kann der Anwender auf "wiederholen" clicken
und dann funktioniert es.

----------------------------------------------------------
Probleme wg. des UEFI-BIOS.

Erfolgreich clonen kann man mit Acronis True Image 2013 so:
Backup unter Windows starten. Sektorweise kopieren. (Das dauert richtig lange).

Zum Clonen mit der bootbaren Acronis CD den Rechner booten.
Im Acronis Tool das zuvor erstellte Backup auswählen.

    Davon dann die 100MB Partition (soll wohl UEFI sein) auswählen und die Windows Partition.

    NICHT aber den MBR.

Backup zurückspielen, 
ggf. vorher alles auf dem Laufwerk löschen (dauert beides richtig lange), z.B. auch ein zuvor angelegten MBR.

