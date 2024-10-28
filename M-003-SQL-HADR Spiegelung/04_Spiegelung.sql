/*

Vorbereitung

Wiederherstellungsmodell= FULL !
Vollsicherung + TLogsicherung


--Wir brauchen ein Login auf beiden Seiten, mit dem das Spiegeln betrieben wird
--Im Assistent wird man gefragt.. gibt man nichts ,wird das Dienstkonto
--verwendet.---> SQL Server Dienst

*/

BACKUP DATABASE [SpiegelDB]
	TO  DISK = N'C:\_SQLBACKUPS\STDINSTANZ\SpiegelDB.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'SpiegelDB-Vollständig Datenbank Sichern', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP LOG [SpiegelDB] TO  DISK = N'C:\_SQLBACKUPS\STDINSTANZ\SpiegelDB.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'SpiegelDB-LOG Datenbank Sichern', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


USE [master]
GO

/****** Object:  Endpoint [Spiegelung]    Script Date: 20.01.2022 14:27:02 ******/
CREATE ENDPOINT [Spiegelung] 
	STATE=STARTED
	AS TCP (LISTENER_PORT = 5022, LISTENER_IP = ALL)
	FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE
, ENCRYPTION = REQUIRED ALGORITHM RC4)
GO



--auf Server2 mit Norecovery
USE [master]
RESTORE DATABASE [SpiegelDB] FROM  DISK = N'C:\_SQLBACKUPS\STDINSTANZ\SpiegelDB.bak'
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [SpiegelDB] FROM  DISK = N'C:\_SQLBACKUPS\STDINSTANZ\SpiegelDB.bak' 
WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  STATS = 5

GO


--KOnto für Spiegelung --> Rechte einrichten und Login

--auf beiden Server
USE [master]
GO
CREATE LOGIN [SQLDOM\svcSQL] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO

GRANT CONNECT ON ENDPOINT::Spiegelung TO [SQLDOM\svcSQL]





--TEST..
use SpiegelDB
GO

create table test (id int identity, spx char(4100))



insert into test 
select 'XY'
GO 30000


--Spiegelungsmonitor.. rechte Maustaste auf DB.. Tasks

--Failover auf Prinzipalseite
ALTER DATABASE <database_name> SET PARTNER FAILOVER;
GO

--auf Spiegel
--zwingend
--Eventuell nicht synchronisiert

ALTER DATABASE <database_name> SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS

--per Registrierte Server
--Login anlegen
USE [master]
GO
CREATE LOGIN [SQLDOM\svcSQL] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO




--HV-SQL 2 
USE MASTER

ALTER DATABASE LogShipping 
 SET PARTNER = 'TCP://NodeONE.SQLDOM.dom:5022'
GO 


--auf HV-SQL1
USE MASTER

ALTER DATABASE LogShipping 
 SET PARTNER = 'TCP://nodetwo.sqldom.dom:5022'
GO 