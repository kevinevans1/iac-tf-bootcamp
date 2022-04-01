# iac-tf-bootcamp
IaC Terraform Bootcamp

## Pre-reqs
- Visual Studio Code Visual Studio Code – “IDE”. https://code.visualstudio.com/
- Terraform https://www.terraform.io/downloads
- GIT https://git-scm.com/downloads
- Windows Terminal https://docs.microsoft.com/en-us/windows/terminal/install
- Azure CLI https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
- PowerShell 7 https://github.com/PowerShell/powershell/releases
- Azure PowerShell Modules https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-7.3.2 
- Azure subscription https://portal.azure.com

### Boot Camp Steps

1. Install and download prerequisites
2. Configure VS Code (Extensions)
3. Configure Terraform (Extract Terraform executable to c:\terraform)
   - To add the Terraform executable directory to your PATH variable:

    - - Click on the Start menu and search for Settings. Open the Settings app.
    - - Select the System icon, then on the left menu, select the About tab. Under Related settings on the right, select Advanced system settings.
    - - On the System Properties window, select Environment Variables.
    - - Select the PATH variable, then click Edit.
    - - Click the New button, then type in the path where the Terraform executable is located.

### Azure Subscription Configuration
#### Azure CLI
1. az login (login)
2. set azure subscription reference az account set --subscription "my sub"

#### Azure PowerShell
1. Connect-AzAccount
2. Set-AzContext -Subscription "Subscription String"

### Configure Git
#### Perform via terminal
1. Set your username: git config --global user.name "FIRST_NAME LAST_NAME"
2. Set your email address: git config --global user.email "MY_NAME@example.com"

### Create Terraform Backend
1. Navigate to to Terraform_remote_backend folder.
2. Run the "azure_remote_backend.azcli"  line by line in terminal
3. View the shared access key in terminal "$env:ARM_ACCESS_KEY=$ACCOUNT_KEY "

### Initialize Terraform
1. Open your terminal
2. Navigate to your Terraform working directory via the CLI (cd..)
3. Save current configuration 
4. Run "terraform init" to initialize terraform backend and providers
5. Run "terraform plan" to check current state
6. Run "terraform apply" to deploy test deployment (a resource group should be created)
7. Run "terraform destroy" to destroy our test deployment

### L2 Resource Deployment
In this module we will deploy the following resources into a single resource group. We will also utilize variables.

The following resources will be deployed:
- Resource Group
- Storage Account
- Virtual Network
- Subnet
- Network Security Group
- Windows Virtual Machine (Compute,Storage,Networking)