# 🌐 Capstone Project: Deploy a Static Website Using Azure Virtual Machine

## 📘 Project Overview
This project demonstrates how to **deploy a static website** on a **Microsoft Azure Virtual Machine (VM)**, configure the necessary **networking components**, and automate the process using **Bash scripting**.  
It is designed as part of the Azure Cloud Capstone Project to strengthen hands-on understanding of **cloud infrastructure, networking, and deployment automation**.

---

## 🏗️ Project Architecture

The solution involves deploying and connecting multiple Azure resources to host and expose a static website on the internet.  

### 🔹 Architecture Components:
1. **Resource Group:** Logical container for all Azure resources in the project.
2. **Virtual Network (VNet):** Provides a secure private network for the virtual machine.
3. **Subnets:** Logical network divisions within the VNet to organize resources.
4. **Network Security Group (NSG):** Controls inbound and outbound network traffic.
5. **Virtual Machine (VM):** Ubuntu Linux VM hosting the NGINX web server.
6. **Public IP Address:** Provides internet access to the VM.
7. **NGINX Web Server:** Serves the static website.
8. **GitHub Repository:** Stores all scripts, website files, and documentation.

---

## ⚙️ Step-by-Step Implementation

### **A1: Create Project Workspace in Azure Cloud Shell**
- Launched **Azure Cloud Shell** (Bash environment).
- Created a working directory for the project:
  ```bash
  mkdir capstone-project
  cd capstone-project
A2: Create GitHub Repository & Connect to Cloud Shell
Created a new repository on GitHub.

Initialized Git inside Cloud Shell:

bash
Copy code
git init
Connected local repo to GitHub:

bash
Copy code
git remote add origin <repo-URL>
A3: Add README & Initial Commit
Created a README.md file with project summary.

Added and committed the file:

bash
Copy code
git add README.md
git commit -m "Initial commit"
git push -u origin main
A4: Infrastructure Scripting (deploy-infra.sh)
Created a Bash script (deploy-infra.sh) to automate deployment of Azure resources:

bash
Copy code
#!/bin/bash
RESOURCE_GROUP="CapstoneRG"
LOCATION="eastus"
VNET_NAME="CapstoneVNet"
SUBNET_NAME="WebSubnet"
NSG_NAME="CapstoneNSG"
VM_NAME="CapstoneVM"

# Create Resource Group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Virtual Network
az network vnet create --resource-group $RESOURCE_GROUP --name $VNET_NAME --address-prefix 10.0.0.0/16 \
  --subnet-name $SUBNET_NAME --subnet-prefix 10.0.1.0/24

# Create Network Security Group
az network nsg create --resource-group $RESOURCE_GROUP --name $NSG_NAME

# Allow SSH & HTTP
az network nsg rule create --resource-group $RESOURCE_GROUP --nsg-name $NSG_NAME --name Allow-SSH \
  --protocol tcp --priority 1000 --destination-port-ranges 22 --access allow
az network nsg rule create --resource-group $RESOURCE_GROUP --nsg-name $NSG_NAME --name Allow-HTTP \
  --protocol tcp --priority 1001 --destination-port-ranges 80 --access allow

# Create Virtual Machine
az vm create --resource-group $RESOURCE_GROUP --name $VM_NAME \
  --image UbuntuLTS --vnet-name $VNET_NAME --subnet $SUBNET_NAME \
  --nsg $NSG_NAME --admin-username azureuser --generate-ssh-keys
A5: Configure the VM and Web Server
Connected to the VM via SSH:

bash
Copy code
ssh azureuser@<Public-IP>
Installed NGINX:

bash
Copy code
sudo apt update
sudo apt install nginx -y
Verified installation by visiting http://<Public-IP>
→ Displayed “Welcome to NGINX”

A6: Deploy the Static Website
Cloned the website files from the repository:

bash
Copy code
git clone <your-github-repo-url>
Moved the website files to NGINX’s default HTML directory:

bash
Copy code
sudo mv website/* /var/www/html/
Verified deployment:
Visiting http://<Public-IP> now displayed
“Welcome to my Capstone Project — Successfully deployed a static website using Azure Virtual Machine.”

A7: Security and Validation
Configured NSG to allow inbound HTTP (port 80) and SSH (port 22) traffic.

Confirmed connectivity by accessing the website from a web browser.

Tested SSH connectivity again to verify stable network setup.

A8: Commit and Push All Project Files
Pushed final code, website files, and scripts back to GitHub:

bash
Copy code
git add .
git commit -m "Final project - deployed static website on Azure VM"
git push
🧠 Key Learnings
Understood the Azure resource hierarchy (Resource Group → VNet → Subnet → NSG → VM).

Learned how to automate resource deployment using Azure CLI and Bash scripting.

Managed source control and versioning with Git & GitHub.

Gained practical experience with Linux commands and NGINX web server configuration.

🏁 Final Result
A static website successfully deployed on an Azure Virtual Machine, accessible publicly through its IP address.

Example output:

“Welcome to my Capstone Project — Successfully deployed a static website using Azure Virtual Machine!”

👩🏽‍💻 Author
Paulina Agoudavi
Capstone Project — Azure Cloud Fundamentals
November 2025
