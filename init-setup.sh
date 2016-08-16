#!/bin/bash

DIST_VER=`lsb_release -rs`

INSSTR=""
PPASTR=""

PPAFLAG=false

#################################
# FUNC
#################################

askIfInstall()
{
  echo "Do you want to install =>> $1 ? (y/n)"
  read TMP
  if [ $TMP == "y" -o $TMP == "yes" ]
  then
  INSSTR="$INSSTR $1"
  echo ""
  fi
}

askIfAddPPA()
{
  echo "Do you want to add PPA repository =>> $1 ? (y/n)" 
  read TMP

  if [ $TMP == "y" -o $TMP == "yes" ]
  then
  PPASTR="$PPASTR $2"
  INSSTR="$INSSTR $1"
  echo ""
  PPAFLAG=true
  fi
}

#################################
# MAIN
#################################

echo "#############################"
echo "# Write home folder in english."
echo "#############################"

echo "Are you OK ?? (y/n)"
read TMP
if [ $TMP == "y" -o $TMP == "yes" ]
then
  LANG=C xdg-user-dirs-gtk-update 
fi

echo "#############################"
echo "# Construct japanese environment."
echo "#############################"

echo "Are you OK ?? (y/n)"
read TMP
if [ $TMP == "y" -o $TMP == "yes" ]
then
  wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
  wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
  sudo wget https://www.ubuntulinux.jp/sources.list.d/xenial.list -O /etc/apt/sources.list.d/ubuntu-ja.list
  askIfInstall ubuntu-default-ja
fi

#echo "#############################"
#echo "# PPA"
#echo "#############################"
#askIfAddPPA ubuntu-defaults-ja ppa:japaneseteam/ppa

echo "#############################"
echo "# INSTALL"
echo "#############################"
askIfInstall vim
askIfInstall vim-gnome
askIfInstall terminator
askIfInstall trash-cli
askIfInstall synaptic
#askIfInstall chromium-browser
#askIfInstall midori
askIfInstall openssh-server
askIfInstall gparted
askIfInstall gdebi
askIfInstall nautilus-dropbox
askIfInstall gnome-tweak-tool

echo "#############################"
echo "# RESULT"
echo "#############################"

echo "Add PPA repository = $PPASTR"
echo ""
echo "Install software = $INSSTR"

echo "Are you OK?? (y/n)"
read TMP
if [ $TMP == "y" -o $TMP == "yes" ]
then

  if [ $PPAFLAG == true ]
  then
    for PPA in $PPASTR
    do
      sudo add-apt-repository $PPA
      #sleep 1s
    done
  fi
  
  sudo apt-get update
  sleep 1s
  sudo apt-get install $INSSTR

  echo "#############################"
  echo "# Install Success!!"
  echo "#############################"
fi
