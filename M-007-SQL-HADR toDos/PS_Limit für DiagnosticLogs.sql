# Konfiguriere die Variablen f�r die Log-Dateien
$logFolderPath = "C:\Pfad\zu\deinen\DiagnoseLogs"  # Pfad zum Diagnoseprotokollordner
$maxFolderSizeMB = 500  # Maximale Gesamtgr��e aller Log-Dateien in MB
$maxFileCount = 10  # Maximale Anzahl an Protokolldateien, die aufbewahrt werden sollen

# Berechne die Gr��e des Log-Ordners
function Get-FolderSize {
    param ($folderPath)
    $size = (Get-ChildItem -Path $folderPath -File | Measure-Object -Property Length -Sum).Sum
    return [math]::Round($size / 1MB, 2)  # Ausgabe in MB
}

# L�sche die �ltesten Dateien, bis die Gesamtgr��e und Anzahl unter den Limits liegen
function Manage-LogFiles {
    param ($folderPath, $maxSizeMB, $maxCount)
    
    # Erhalte alle Dateien im Ordner, sortiere sie nach Erstellungsdatum (�lteste zuerst)
    $files = Get-ChildItem -Path $folderPath -File | Sort-Object LastWriteTime

    # L�sche Dateien, wenn Anzahl der Dateien �berschritten ist
    while ($files.Count -gt $maxCount) {
        Remove-Item -Path $files[0].FullName -Force
        $files = $files | Select-Object -Skip 1
    }

    # L�sche Dateien, wenn Gesamtgr��e �berschritten ist
    while ((Get-FolderSize -folderPath $folderPath) -gt $maxSizeMB) {
        Remove-Item -Path $files[0].FullName -Force
        $files = $files | Select-Object -Skip 1
    }
}

# Hauptteil des Skripts
Manage-LogFiles -folderPath $logFolderPath -maxSizeMB $maxFolderSizeMB -maxCount $maxFileCount
Write-Output "Log-Ordner aufger�umt. Aktuelle Gr��e: $(Get-FolderSize -folderPath $logFolderPath) MB"
