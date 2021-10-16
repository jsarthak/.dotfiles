#!/bin/bash

sudo apt install apt-transport-https curl


sudo curl -fsSLo /usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg https://brave-browser-apt-nightly.s3.brave.com/brave-browser-nightly-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg arch=amd64] https://brave-browser-apt-nightly.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-nightly.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list


sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install awscli
install apt-transport-https
install neofetch
install cowsay
install fortune
install chromium-browser
install curl
install exfat-utils
install file
install git
install htop
install nmap
install openvpn
install tmux
install vim
install virtualbox
install vlc
install ubuntu-restricted-extras
install audacity
install geany
install adb
install sublime-text
install bleachbit
install dconf-cli
install gnome-tweaks
install gdebi
install gparted
install zotero
install terminator
install shotwell
install keepassxc
install brave-browser-nightly


#printing
install hplip-gui

# Image processing
install gimp
install inkscape
install darktable

# Fun stuff
install figlet
install lolcat
