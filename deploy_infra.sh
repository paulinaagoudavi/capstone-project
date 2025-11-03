#!/bin/bash

# ========== VARIABLES ==========
RESOURCE_GROUP="CapstoneResourceGroup"
LOCATION="eastus"
VNET_NAME="CapstoneVNet"
SUBNET_NAME="CapstoneSubnet"

# ========== CREATE RESOURCE GROUP ==========
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# -----------------------------
# A4 - Create VNet and Subnets
# -----------------------------

# Variables
RESOURCE_GROUP="CapstoneResourceGroup"
LOCATION="eastus"
VNET_NAME="CapstoneVnet"
VNET_ADDRESS_PREFIX="10.0.0.0/16"
SUBNET1_NAME="frontend-subnet"
SUBNET1_PREFIX="10.0.1.0/24"
SUBNET2_NAME="backend-subnet"
SUBNET2_PREFIX="10.0.2.0/24"

# Create the Virtual Network
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix $VNET_ADDRESS_PREFIX \
  --subnet-name $SUBNET1_NAME \
  --subnet-prefix $SUBNET1_PREFIX

# Create the second Subnet
az network vnet subnet create \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET2_NAME \
  --address-prefixes $SUBNET2_PREFIX

# -----------------------------
# A5 - Create and Associate NSG
# -----------------------------

# Variables
RESOURCE_GROUP="CapstoneResourceGroup"   
LOCATION="eastus"
NSG_NAME="capstone-nsg"
VNET_NAME="CapstoneVnet"
SUBNET1_NAME="frontend-subnet"

# Create the Network Security Group
az network nsg create \
  --resource-group $RESOURCE_GROUP \
  --name $NSG_NAME \
  --location $LOCATION

# Add a rule to allow HTTP (port 80)
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name "Allow-HTTP" \
  --protocol Tcp \
  --direction Inbound \
  --priority 1000 \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 80 \
  --access Allow \
  --description "Allow HTTP traffic on port 80"

# Add a rule to allow SSH (port 22)
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name "Allow-SSH" \
  --protocol Tcp \
  --direction Inbound \
  --priority 1001 \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 22 \
  --access Allow \
  --description "Allow SSH access"

# Associate NSG with frontend subnet
az network vnet subnet update \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET1_NAME \
  --network-security-group $NSG_NAME

# -----------------------------
# A6 - Create Virtual Machines
# -----------------------------

# Variables
RESOURCE_GROUP="CapstoneResourceGroup"   
LOCATION="eastus"
VNET_NAME="CapstoneVnet"
SUBNET1_NAME="frontend-subnet"
SUBNET2_NAME="backend-subnet"
NSG_NAME="capstone-nsg"

# Frontend VM
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name frontend-vm \
  --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET1_NAME \
  --nsg $NSG_NAME \
  --public-ip-address frontend-ip

# Backend VM
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name backend-vm \
  --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET2_NAME \
  --nsg "" \
  --public-ip-address backend-ip

