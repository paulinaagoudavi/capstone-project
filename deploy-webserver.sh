#!/bin/bash
# deploy-webserver.sh
# Installs nginx, pulls static site from GitHub, and deploys it to /var/www/html

set -euo pipefail

# CONFIG — change these if needed
GITHUB_USER="paulinaagoudavi"
REPO_NAME="capstone-project"   # repo that contains website/ folder
SITE_FOLDER="website"                  # relative path inside repo where index.html lives

# 1) Update & install packages
sudo apt update -y
sudo apt install -y nginx git

# 2) Ensure nginx is enabled and running
sudo systemctl enable nginx
sudo systemctl start nginx

# 3) Deploy site: clone or update repo to /tmp/site
TMPDIR="/tmp/site"
if [ -d "$TMPDIR/.git" ]; then
  sudo rm -rf "$TMPDIR"
fi

sudo git clone "https://github.com/${GITHUB_USER}/${REPO_NAME}.git" "$TMPDIR" || (cd "$TMPDIR" && sudo git pull)

# 4) Copy website files into nginx webroot
sudo rm -rf /var/www/html/*
if [ -d "${TMPDIR}/${SITE_FOLDER}" ]; then
  sudo cp -r "${TMPDIR}/${SITE_FOLDER}/." /var/www/html/
else
  # fallback: if you didn't create website folder yet, create a simple page
  echo "<h1>Welcome — Static site not found in repo</h1><p>Replace with your site files in ${REPO_NAME}/${SITE_FOLDER}</p>" | sudo tee /var/www/html/index.html
fi

# 5) Fix permissions
sudo chown -R www-data:www-data /var/www/html

echo "✅ deploy-webserver.sh finished — nginx running and site deployed (if repo exists)."
