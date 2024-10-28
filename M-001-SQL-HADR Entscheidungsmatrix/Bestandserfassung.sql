/*
Für Hochverfügbarkeit lohnt es sicht die System rel identisch aufzusetzen. Dazu gehören Pfade und Dienstkonten

Natürlich sollten auch die Hardwareressourcen identisch sein, um einen ansatzweise idetnische Performance hinzubekommen

Viele HADR Lösungen beginnen mit V Sicherung .. 


Bei uns:


Pfade

C:\_SQLDBS
C:\BACKUP ...   C:\_SQLBackups

\\hv-sql1\backup


Sicherung komprimiert


ppedv2019!

SQL Server Dienst: schulung\svcSQL
SQL Agent		 : schulung\sqlAgent



V    D   TTTT60min nixTTTTTTT



				ServerNetz			ClientNetz
HV-DC			192.168.138.1		192.168.137.1
HV-SQL1			192.168.138.2		192.168.137.2
HV-SQL2			192.168.138.3		192.168.137.3
NTCLUST								192.168.137.4
SQLCLUST							192.168.137.5
SQLAVG								192.168.137.6





192.168.1.1
192.168.10.1

TCP://nodetwo.sqldom.dom:5022
TCP://nodeone.sqldom.dom:5022



