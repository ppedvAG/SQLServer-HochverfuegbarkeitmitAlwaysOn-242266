/*


LS: lesbare Replikas
LS: n-fache Replikas

SP: synrchon
SP: Failover unter 3 Sek
SP: autom. Failover mit CLient Redirect, ABER!!!!

CL: VName
CL: automatischer Failover, aber nicht auf DB Niveau


AVG
lesbare Replikas
bis zu 8 Replikas
synrchon
Failover unter 3 Sek
autom. Failover mit CLient Redirect
FO auf DB Niveau
Leserouting.. Lesevorgänge gezielt an andere Servert weiterreichen
Gruppen von DB

--First toDo

--Vollsicherung
--RecModel: FULL
--Cluster vorhanden
--Avg aktivieren
--evtl SSMS aktualsieren

*/
ALTER DATABASE [AG1] SET HADR AVAILABILITY GROUP = [AG_Gruppe];

GO

