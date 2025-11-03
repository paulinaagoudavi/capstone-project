# Capstone Project: Deploy a Static Website using Azure

## Overview
This project demonstrates how to deploy a **static website** on an **Azure Virtual Machine (Ubuntu)**, automate the setup using shell scripts, and manage source code with **GitHub**.

## Architecture
The infrastructure includes:
- **Resource Group:** To contain all project resources  
- **Virtual Network (VNet):** Provides a private network for resources  
- **Subnets:** Segments the network logically  
- **Network Security Group (NSG):** Controls inbound and outbound traffic  
- **Virtual Machine (VM):** Hosts the NGINX web server to serve the static website  
- **Public IP Address:** Allows external access to the website  

## Tools & Technologies
- Azure Cloud Shell  
- Azure CLI  
- Git & GitHub  
- NGINX Web Server  
- Bash Scripting  

## Result
The website is live and accessible via the VM’s public IP, showing the message:  
**“Welcome to my Capstone Project — Successfully deployed a static website using Azure Virtual Machine!”**
