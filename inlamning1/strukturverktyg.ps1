# Create directories for a user
function CreateUserDirectories {
    param (
        [string]$name,
        $date
    )

    try {
        New-Item -ItemType Directory -Name $name
        New-Item -ItemType Directory -Path "$name/logs"
        New-Item -ItemType Directory -Path "$name/scripts"
        New-Item -ItemType Directory -Path "$name/temp"
    }
    catch {
        Write-Output "Error: Failed to create directory, it might already exist"
    }
}

#Create a log file for user with current date & time
function CreateLogFile {
    param (
        [string]$name,
        $date,
        $time
    )

    New-Item -ItemType File -Path "$name/logs/log-$date.txt"

    $logText = "Struktur skapad: $date $time"
    Add-Content -Path "$name/logs/log-$date.txt" -Value $logText
}

# Asks user for name, and creates directories and a log file for the user
function Main {
    try {
        $name = Read-Host "Ange ditt namn"

        $date = (Get-Date -Format "yyyy-MM-dd").toString()
        $time = (Get-Date -Format "HH:mm").toString()

        CreateUserDirectories -name $name -date $date 
        CreateLogFile -name $name -date $date -time $time
    }
    catch {
        Write-Output "Error: Invalid input"
    }
}

Main
