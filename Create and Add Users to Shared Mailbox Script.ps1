# ---------------------------
# Script: Create and Add Users to Shared Mailbox
# Description: Checks if a shared mailbox exists. If not, creates it and assigns permissions to specified users.
# Author: Your Name
# Date: 2024-04-27
# ---------------------------

# ---------------------------
# Function to Install Exchange Online Module
# ---------------------------
function Install-ExchangeOnlineModule {
    try {
        Write-Host "Installing Exchange Online PowerShell module..." -ForegroundColor Cyan
        Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force -AllowClobber
        Write-Host "Exchange Online PowerShell module installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install Exchange Online PowerShell module. Please install it manually." -ForegroundColor Red
        exit
    }
}

# ---------------------------
# Import Exchange Online Module
# ---------------------------
try {
    Import-Module ExchangeOnlineManagement -ErrorAction Stop
} catch {
    Write-Host "Exchange Online PowerShell module not found. Attempting to install..." -ForegroundColor Yellow
    Install-ExchangeOnlineModule
    try {
        Import-Module ExchangeOnlineManagement -ErrorAction Stop
    } catch {
        Write-Host "Failed to import Exchange Online PowerShell module even after installation. Exiting script." -ForegroundColor Red
        exit
    }
}

# ---------------------------
# Connect to Exchange Online
# ---------------------------
try {
    Write-Host "Connecting to Exchange Online..." -ForegroundColor Cyan
    Connect-ExchangeOnline -ShowProgress $true -ErrorAction Stop
    Write-Host "Connected to Exchange Online successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to connect to Exchange Online. Please check your credentials and internet connection." -ForegroundColor Red
    exit
}

# ---------------------------
# Define Variables
# ---------------------------
# Shared Mailbox Details
$SharedMailbox = "shared.support@domain.com"
$BaseDisplayName = "Support Mailbox"
$DisplayNameSuffix = "(Domain) Mailbox"
$DisplayName = "$BaseDisplayName $DisplayNameSuffix"
$Alias = "shared.support"

# Users to Assign Permissions
$Users = @(
    "user1@domain.com",
    "user2@domain.com",
    "user3@domain.com",
    "user4@domain.com"
)

# Authorizing Manager (Optional: You can use this variable if needed in the script)
$AuthorizingManager = "manager@domain.com"

# Unicode Symbols for Visual Indicators
$SuccessSymbol = [char]0x2713   # ✓
$FailureSymbol = [char]0x2717   # ✗

# ---------------------------
# Check and Create Shared Mailbox
# ---------------------------
try {
    $Mailbox = Get-Mailbox -Identity $SharedMailbox -ErrorAction Stop
    Write-Host "$SuccessSymbol Shared mailbox '$SharedMailbox' already exists." -ForegroundColor Green
} catch {
    Write-Host "$FailureSymbol Shared mailbox '$SharedMailbox' does not exist. Creating..." -ForegroundColor Yellow
    try {
        New-Mailbox -Shared -Name $BaseDisplayName -DisplayName $DisplayName -Alias $Alias -PrimarySmtpAddress $SharedMailbox -ErrorAction Stop
        Write-Host "$SuccessSymbol Shared mailbox '$SharedMailbox' has been created." -ForegroundColor Green
    } catch {
        Write-Host "$FailureSymbol Failed to create shared mailbox '$SharedMailbox'." -ForegroundColor Red
        Disconnect-ExchangeOnline -Confirm:$false
        exit
    }
}

# ---------------------------
# Assign Permissions to Users
# ---------------------------
foreach ($User in $Users) {
    Write-Host "Assigning permissions to $User..." -ForegroundColor Cyan
    try {
        # Assign Full Access Permission
        Add-MailboxPermission -Identity $SharedMailbox -User $User -AccessRights FullAccess -InheritanceType All -AutoMapping $true -ErrorAction Stop
        
        # Assign Send As Permission
        Add-RecipientPermission -Identity $SharedMailbox -Trustee $User -AccessRights SendAs -Confirm:$false -ErrorAction Stop
        
        Write-Host "$SuccessSymbol Permissions assigned to $User." -ForegroundColor Green
    } catch {
        Write-Host "$FailureSymbol Failed to assign permissions to $User. $_" -ForegroundColor Red
    }
}

# ---------------------------
# Disconnect from Exchange Online
# ---------------------------
Disconnect-ExchangeOnline -Confirm:$false
Write-Host "$SuccessSymbol Disconnected from Exchange Online." -ForegroundColor Green

# ---------------------------
# Final Completion Message
# ---------------------------
Write-Host "$SuccessSymbol All tasks completed successfully." -ForegroundColor Green
