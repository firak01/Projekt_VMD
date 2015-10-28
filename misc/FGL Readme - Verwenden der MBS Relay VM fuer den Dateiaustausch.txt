2012-10-16

Problematik der Dateiübertragung von einer MBS VMWare oder vom MBS Rechner (Notebook) zu einer FGL VMWare.
Es funktioniert in der FGL VMWare nicht mit einem "Shared Host - Verzeichnis" auf dem MBS Notebook zu arbeiten.

Lösung: 
1. Diese Relay-VM und die FGL VM so einstellen, das sie Netzwerk "Host Only" haben.
2. In der FGL VM ein Verzeichnis freigeben. (Der zugriff aus der fgl VM auf die Relay VM funktioniert nicht).
3. In der Relay-VM mit dem freigegebenen Verzeichnis der FGL VM verbinden (z.B. als Laufwerk Y:). Dabei die IPs nutzen, die durch das "Host Only" entstehen.
4. Diese Relay-VM nutzt "Shared Host" auf ein Verzeichnis (Z:) des MBS Rechners (Notebook).

Nun kann man aus der Relay-VM die Dateien aus dem Z: Laufwerk in das Y: Laufwerk verschieben.