# Konfiguriere die Variablen für die Log-Dateien
$logFolderPath = "C:\Pfad\zu\deinen\DiagnoseLogs"  # Pfad zum Diagnoseprotokollordner
$maxFolderSizeMB = 500  # Maximale Gesamtgröße aller Log-Dateien in MB
$maxFileCount = 10  # Maximale Anzahl an Protokolldateien, die aufbewahrt werden sollen

# Berechne die Größe des Log-Ordners
function Get-FolderSize {
    param ($folderPath)
    $size = (Get-ChildItem -Path $folderPath -File | Measure-Object -Property Length -Sum).Sum
    return [math]::Round($size / 1MB, 2)  # Ausgabe in MB
}

# Lösche die ältesten Dateien, bis die Gesamtgröße und Anzahl unter den Limits liegen
function Manage-LogFiles {
    param ($folderPath, $maxSizeMB, $maxCount)
    
    # Erhalte alle Dateien im Ordner, sortiere sie nach Erstellungsdatum (älteste zuerst)
    $files = Get-ChildItem -Path $folderPath -File | Sort-Object LastWriteTime

    # Lösche Dateien, wenn Anzahl der Dateien überschritten ist
    while ($files.Count -gt $maxCount) {
        Remove-Item -Path $files[0].FullName -Force
        $files = $files | Select-Object -Skip 1
    }

    # Lösche Dateien, wenn Gesamtgröße überschritten ist
    while ((Get-FolderSize -folderPath $folderPath) -gt $maxSizeMB) {
        Remove-Item -Path $files[0].FullName -Force
        $files = $files | Select-Object -Skip 1
    }
}

# Hauptteil des Skripts
Manage-LogFiles -folderPath $logFolderPath -maxSizeMB $maxFolderSizeMB -maxCount $maxFileCount
Write-Output "Log-Ordner aufgeräumt. Aktuelle Größe: $(Get-FolderSize -folderPath $logFolderPath) MB"
