---INVENTUR


/*

Umgebung

schulung\Administrator


RAM: 16 GB- 4 = 12
1 Socket 
4 logische 
						       PRIV1			PRIV2           EXT    DBPFAD      BACKUPPFAD
HV-DC   2048-3048  2 CPUs    192.168.137.1    192.168.138.1     172.   c:\_SQLDBS  C:\BACKUP

HV-SQL1 4500  fix  4 CPUs    192.168.137.2	  192.168.138.2      -     c:\_SQLDBS  C:\BACKUP                                                                            

HV-SQL2 4500 fix   4 CPUs    192.168.137.3	  192.168.138.3
--NUMA KLick


Dienstkonten: 
DBModul schulung\svcSQL  ppedv2019!
Agent:  schulung\sqlAgent ppedv2019!

PRIV1: 192.168.137.??? ClientServernetzwerk

PRIV2: 192.168.138.??? ServerOnlyNetzwerk

--Windows Cluster

virt Computer für FCL: IP  192.168.137.4  NTCLUST

--SQL CLuster
--SQLvPC : 192.168.137.5
--SQLvPC\Dev  


--AVG----
AGXGRUPPE (AG1, AG2)
AGSQL      192.168.137.6


--





