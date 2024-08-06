# Arbeitsagentur Berufenet API 
Die Bundesagentur für Arbeit verfügt mit BERUFENET über das umfangreichste Lexikon der Berufe in Deutschland.

BERUFENET listet etwa 3569 Berufe, davon 830 Ausbildungsberufe, 725 Studiengänge, 748 Weiterbildungsberufe - die zu 94% konkreten Tätigkeiten zugeordnet sind - und 1266 sonstige Tätigkeiten (von Helfertätigkeiten bis zu Hochschulberufen). Insg. werden 2730 Tätigkeiten unterschieden. Neben den gelisteten Berufen ist auch ein Zugriff auf nicht-gelistete Berufe möglich (z.B. ID 1674) jedoch nicht Gegenstand der vorliegenden Dokumentation.


## Authentifizierung
Die Authentifizierung funktioniert über die *clientId* von Berufenet, die einem GET-request an https://web.arbeitsagentur.de/berufenet/ergebnisseite/berufe-a-z entnommen werden kann:

**clientId**: infosysbub-berufenet

Bei folgenden GET-requests ist die clientId als Header-Parameter 'X-API-Key' zu übergeben.



## BERUFENET-Berufeliste

**URL:** https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe
	
Berufenet ermöglicht die Abfrage von Berufs-ID und Kurzbezeichnung zu einer spezifizierten Teilmenge aller auf BERUFENET gelisteten Berufe. Die Spezifikation erfolgt über GET-Parameter, wobei maximal 20 Einträge pro Seite ausgegeben werden (siehe Parameter page).


### Parameter


**Parameter:** *page* (Optional)

Seite (beginnend mit 0). Es werden maximal 20 Einträge pro Seite ausgegeben.


**Parameter:** *suchwoerter*  (Optional)

Suchwörter: Eine Zeichenkette, die in den Informationen zu den angefragten Berufen auftauchen sollten. Ein Sternchen-Symbol ermöglicht die Abfrage aller Berufe.


**Parameter:** *buchstabe*  (Optional)

Buchstabe: Anfangsbuchstabe der angefragten Berufe. Hinweis: Neben Berufen, die mit Buchstaben von A-Z beginnen gibt es zwei Einträge, die auf diese Weise nicht angefragt werden können da sie mit einer Zahl beginnen.


**Parameter:** *berufecluster*  (Optional)

Berufecluster: "TC 0201" = reglementierte Berufe; "TC 101" = Mathematik; "TC 0102" = Informatik; "TC 0103" = Naturwissenschaft; "TC 104" = Technik. Mehrere Komma-separierte Einträge möglich, z.B. "TC 0101,TC 0102,TC 0103,TC 0104" für alle MINT-Berufe.


**Parameter:** *bg*  (Optional)

Berufsgruppe: 100, 102, 105 (= Ausbildungsberufe); 200, 201, 203, 204 (= Weiterbildungsberufe); 300, 301, 302 (= Studienfächer); 400, 401, 402 (=Hochschulberufe); 500, 503 (=Beamtenlaufbahn), 700 (=Berufliche Einsatzmöglichkeiten). Mehrere Komma-separierte Einträge möglich.


### Beispiel:

```bash
berufe=$(curl -m 60 \
-H "X-API-Key: d672172b-f3ef-4746-b659-227c39d95acf" \
"https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe?suchwoerter=*&page=0")
```




## BERUFENET-Berufsinformationen

**URL:** https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe/{Berufs-ID}
	
Berufenet ermöglicht die Abfrage von umfangreichen Informationen zu einer Berufs-ID (z.B. 129987).
Die Informationen umfassen:
- Berufs-ID
- kldb2010-Code
- Kurzbezeichnung
- Bezeichnung
- Code-Nr.
- Bilder
- BKGR
- Beschreibung
- Infofelder
- Steckbrief
- Aufstiegsweiterbildungen
- Anpassungsweiterbildungen
- Fachrichtungen
- Meta-Fachrichtung
- Tätigkeitsfelder
- Einsatzmöglichkeiten
- Metaeinheit

Zu Ausbildungsberufen, Weiterbildungsberufen und Studiengängen werden darüber hinaus idR. Informationen zu einer zugeordneten Tätigkeit ausgewiesen (mit separater Berufs-ID).

### Beispiel:

```bash
berufeinfo=$(curl -m 60 \
-H "X-API-Key: infosysbub-berufenet" \
"https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe/129987")
```



