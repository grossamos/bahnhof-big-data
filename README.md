# R Hausarbeit

## Fragestellung

- Sind Bahnhöfe in Deutschland gerecht verteilt?
- Haben alle menschen den gleich einfachen Zugriff auf Bahnverbindungen/Bahnhöfe
- Bspw. ist es leichter in einem Dorf in Hessen an einen Bahnhof zu kommen als in Bayern
- Dort wo die höchste Einwohnerdichte ist gibt es die meisten Bahnhöfe (bspw. Stadt mehr als Land) und erwartung ist, dass sich dieses Verhältnis nicht zwischen Bundesländern unterscheidet (bspw. gleiches ratio von Einwohnerdichte zu Bahnhofsanzahl)

## Gaphen oder analysen die wir machen können
- wie viele personen haben einen Bahnhof in ihrer Plz
- wie groß ist die durchschnittliche postleitzahl (evtl. auch vgl osten westen)
- in eddies vergleich große der Stadt miteinbeziehen
- Auftraggeber und Verkehrsbund vergleichen (einfach nochmal einen Graphen zu verkehrsbund machen)
- Kategorieverteilung je Bundesland

Fun facts:

- Wie viele Bahnhöfe sind in der Bahnhofstraße
- Größe der Postleitzahlen ~ bevölkerungsdichte/bevölkerung

## Vorgehen

- Maps Nutzen um Auffälligkeiten zu finden
  1. Stadt und Land ist unterschiedlich
  2. Bahnhofshäufigkeit in Ost und West ist unterschiedlich -> einfach wegen größeren PLZ -> spiegelt sich aber auch in nationaler karte wieder...?
  3. Abdeckung bei Ländergrenzen: am besten bei Polen > Luxemburg, Frankreich, Österreich, Schweiz > Belgien, Dänemark > Czechien
  4. Bahnhofsdichte entspricht so ca. Bevölkerungsdichte
- Analysen auf Auffälligkeiten
  1. Stadt/Land
  2. Ost/West
  - Prozentsatz der Ortschaften mit bahnhöfen sortiert nach Bevölkerungszahl der Plz (in quantilen, über 3k, über 100, über 100k...)
  3. Ländergrenzen
  -
  - Städte/Land im vergleich (dichte über/unter schwellenwert pro einwohner)
  - Länder im Vergleich
- Allgemeine Analysen
  - wie sind bevölkerung und bahnhofsdichte korreliert
- Störgründe für trends bedenken:
  - bspw. Abwanderung aus dem Osten

## Datensätze

- Bevölkerungsdaten: https://www.suche-postleitzahl.org/downloads
- Stationsdatem: https://data.deutschebahn.com/dataset/data-stationsdaten.html
- Shapefiles: https://geodata.lib.utexas.edu/catalog/stanford-nh891yz3147

## Ideas

### Only Bahnhof

- Allgemein Bahnhofdichte (Karte)
- Wieviele Bahnhöfe sind in der Bahnhofstraße (most common straßennahmen)
  - in relation zu typ (mehr oder weniger typ 1/6 an Bahnhofstraße?)

### Only Population

- Allgemein Bevölkerungsdichte (Karte)
- Korrelation größe und einwohnerzahl pro plz
- Korrelation größe und bevölkerungsdichte pro plz

### Kombiniert

#### Kartenvisualisierung

- Für jede Postleitzahl Bahnof/Einwohner (Karte)

#### Nicht Kartenvisualisierung

- Bahnhöfe pro Bundesland (Bar chart)
- Bahnhöfe pro Regionalbezirk
- Kategorie pro Regionalbezirk (gibt es überwiegend typ 1 in Mitte?)
- Anzahl bahnhöfe pro PlZ (Bar Chart)
  - Geordenet nach Anzahl
  - Geordenet nach Anzahl pro Einwohner
  - Gruppiert nach Bundesland
  - Gruppiert nach erster Ziffer der PLZ
  - Anzahl der Bahnhöfen sortiert nach Bevölkerungsdichte (Land vs. Stadt)

#### Karten und Nichtkartenvisualisierung

- Typ des Bahnhofs
  - sortiert nach Bundesland
  - heatmap nach Plz
- Aufgabenträger je Bahnhof je Plz (wie viel overlap der aufgabenträger gibt es, bzw wie abgetrennt sind sie)

- (Daten benötigt) Güterbahnhof dichte vgl mit bevölkerungsdichte

## ChatGPT schlägt vor

- Wo befinden sich die Bahnhöfe im Verhältnis zueinander? Kann man Rückschlüsse auf die geographische Lage der Bahnhöfe ziehen, z.B. ob sie sich in ländlichen oder städtischen Gebieten befinden?
- In welchen Bundesländern befinden sich die meisten Bahnhöfe? Gibt es Unterschiede in der Verteilung der Bahnhöfe in den einzelnen Bundesländern?
- Gibt es eine Korrelation zwischen der Größe eines Bahnhofs (z.B. Anzahl der Gleise, Größe des Bahnhofsgebäudes) und seiner Lage (z.B. Entfernung zu einer Stadt, Entfernung zu einer Autobahn)?
- Kann man Rückschlüsse auf die historische Entwicklung der Bahnhöfe ziehen, z.B. ob sie ursprünglich als Durchgangsbahnhöfe oder als Endbahnhöfe geplant waren?
- Kann man mithilfe der Adressinformationen Rückschlüsse auf die Einwohnerzahl der Städte oder Gemeinden ziehen, in denen sich die Bahnhöfe befinden?
- Gibt es Unterschiede in der Verteilung der Bahnhöfe innerhalb von Städten oder Regionen (z.B. innerhalb von Großstädten, ländlichen Regionen)?
- Kann man Rückschlüsse auf die Bedeutung von Bahnhöfen als Verkehrsknotenpunkte ziehen, z.B. indem man die Anzahl der Züge, die an einem Bahnhof halten, mit der Anzahl der Fahrgäste vergleicht, die an diesem Bahnhof ein- oder aussteigen?
- Kann man mithilfe der Adressinformationen Rückschlüsse auf die wirtschaftliche Entwicklung von Städten oder Regionen ziehen, in denen sich die Bahnhöfe befinden (z.B. durch Vergleich mit Daten zu Industrieparkgrößen oder -standorten in der Nähe der Bahnhöfe)?
- Kann man mithilfe der Adressinformationen Rückschlüsse auf die Verkehrsinfrastruktur (z.B. Straßen, Flughäfen) in der Nähe von Bahnhöfen ziehen?
- Gibt es Unterschiede in der Verteilung von Bahnhöfen
