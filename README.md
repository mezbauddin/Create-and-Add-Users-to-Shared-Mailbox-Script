
# Create and Add Users to Shared Mailbox Script

## Overview

This PowerShell script checks if a shared mailbox exists in Microsoft 365 Exchange Online. If the shared mailbox does not exist, the script creates it and assigns **Full Access** and **Send As** permissions to specified users.

## Features

- **Mailbox Existence Check**: The script checks if the shared mailbox already exists before creating it.
- **Shared Mailbox Creation**: Automatically creates a shared mailbox if it does not exist.
- **Permission Assignment**: Assigns **Full Access** and **Send As** permissions to a list of users.
- **Visual Indicators**: Uses symbols to visually indicate success (`✓`) or failure (`✗`) for each task.

## Prerequisites

- **PowerShell**: Ensure you are running PowerShell version 5.1 or later.
- **Exchange Online Management Module**: The script will automatically check for and install this module if necessary.
- **Exchange Online Administrator Access**: The script requires sufficient privileges to create mailboxes and assign permissions.

## Installation

1. **Clone this repository**:
   \`\`\`bash
   git clone https://github.com/yourusername/create-add-users-shared-mailbox.git
   \`\`\`

2. **Navigate to the directory**:
   \`\`\`bash
   cd create-add-users-shared-mailbox
   \`\`\`

3. **Run the script**:
   \`\`\`powershell
   .\Create-AddUsers-SharedMailbox.ps1
   \`\`\`

## Script Parameters

This script defines variables for:
- **Shared Mailbox Details**: The shared mailbox email, display name, and alias.
- **Users to Assign Permissions**: A list of users who will be assigned permissions to the shared mailbox.
- **Authorizing Manager** (Optional): An authorizing manager can be specified if required.

## Example Usage

This script runs without the need for parameters; it operates based on the pre-defined details in the script itself, including the shared mailbox and users.

### Sample Output

The script provides clear output on the console, showing:

1. Whether the shared mailbox exists or is being created.
2. Whether permissions are being assigned to each user, along with success or failure symbols (`✓` or `✗`).

## Sample Code Snippet

\`\`\`powershell
$SharedMailbox = "shared.support@domain.com"
$BaseDisplayName = "Support Mailbox"
$Users = @(
    "user1@domain.com",
    "user2@domain.com"
)
\`\`\`

## Dependencies

This script relies on the Exchange Online Management module. If it’s not installed, the script will install it automatically.

To manually install the module, use:
\`\`\`powershell
Install-Module -Name ExchangeOnlineManagement
\`\`\`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues or pull requests if you find any improvements or bugs.

## Author

**Author Name**  
- LinkedIn: [Author LinkedIn](https://linkedin.com)
