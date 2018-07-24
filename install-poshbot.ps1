#Powershell script to install PoshBot as a service
#Update Bot Name and Slack Token Variable before running
$botname="poshbot"
$botadmins="joe.beaudry","amin.teimoortagh"
$slacktoken="asdfasdfasdf"
$output = 'C:\'

# Set Execution policy
Set-ExecutionPolicy unrestricted

# Install the module from PSGallery
Install-Module -Name PoshBot -Repository PSGallery

# Import the module
Import-Module -Name PoshBot

# Extract files

Expand-Archive -Path poshbot.zip -DestinationPath  $output -force

# Modify 'BotAdmins" & 'Token' before running script
# Create bot configuration
$botParams = @{
    Name = "$botname"
    BotAdmins = @($botadmins)
    CommandPrefix = '!'
    LogLevel = 'Info'
    BackendConfiguration = @{
        Name = 'SlackBackend'
        Token = $slacktoken
    }
    AlternateCommandPrefixes = 'bender', 'hal'
}

$myBotConfig = New-PoshBotConfiguration @botParams
Save-PoshBotConfiguration -InputObject $myBotConfig -Path C:\poshbot\Config.psd1 -force

# Run PoshBot as a service
C:\poshbot\service-poshbot.ps1
