#!/bin/bash

INSSTR=""
PPASTR=""


insfunc()
{
  
  echo "Do you install =>> $1 ? (y/n)"
  read TMP

  if [ $TMP == "y" -o $TMP == "yes" ]
  then
  INSSTR="$INSSTR $1"
  echo $INSSTR
  echo ""
  fi

}

insppa()
{
  echo "Do you add ppa repository =>> $1 ? (y/n)" 
  read TMP

  if [ $TMP == "y" -o $TMP == "yes" ]
  then
  PPASTR="$PPASTR $2"
  INSSTR="$INSSTR $1"
  echo $PPASTR
  echo ""
  fi
}




echo "#############################"
echo "# PPA"
echo "#############################"

insppa ubuntu-default-ja ppa:japaneseteam/ppa
insppa firefox ppa:mozillateam/firefox-next
insppa libreoffice ppa:libreoffice/ppa
insppa gimp ppa:otto-kesselgulasch/gimp
insppa virtualbox ppa:debfx/virtualbox



echo "#############################"
echo "# INSTALL"
echo "#############################"

insfunc vim
insfunc vim-gnome
insfunc terminator
insfunc trash-cli
insfunc synaptic
insfunc chromium-browser
insfunc midori
insfunc openssh-srver
insfunc gparted
insfunc ibus-mozc
insfunc gdebi


echo "#############################"
echo "# RESULT"
echo "#############################"

echo "PPASTR = "
echo $PPASTR
echo ""
echo "INSSTR = "
echo $INSSTR
