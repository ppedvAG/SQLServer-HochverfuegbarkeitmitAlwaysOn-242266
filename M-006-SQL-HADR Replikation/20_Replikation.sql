/*
--Repl arten

Die Ziel DB muss nicht wie das Orig lauten
Teile der DB (horiz und vertikalen Filterung

select sp1, sp3 from tabelle where spx = 10


Push Abo: der Abo bekommt sie vom Verteiler (Auftrag liegt bei Verteiler)
Pull Abo: der Abo holt sich die Daten (Auftrag liegt bei Abo)

Snapshotreplikation:

Paket geschnürt mit akt Daten-->Abo als Basis

----oneway--imm ernur Richtung Abo aktualsierbar
jeder neue Abo bekommt zu Beginn immer einen Snapshot


Transaktionsprotokollreplikation
1. Snapshot--- Datei
2. lfd Aktualisierung der Daten
---> oneway -- nur der Abo wird aktualisiert


Merge Replikation
1. Snapshot
2. TX werden ausgetauscht-- in beide Richtungen

jeder kann den anderen aktualsieren

ID Pakete
GUID

select newid()..DD6A20E1-7EC8-4D40-A267-AFD2533937F5
man braucht eine neue Spalte rowguid

--TP Replikation mit akt Abo

--Peer to Peer






--Proxykonten: Ausführen als.. für Agentschritte
SystemDb: distribution







