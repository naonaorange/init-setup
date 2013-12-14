#!/bin/bash

DIST_VER=`lsb_release -rs`

INSSTR=""
PPASTR=""

PPAFLAG=false

#################################
# FUNC
#################################

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
  PPAFLAG=true
  fi
}



#################################
# MAIN
#################################

echo "#############################"
echo "# Home直下を英語にする"
echo "#############################"

echo "Are you OK ?? (y/n)"
read TMP

if [ $TMP == "y" -o $TMP == "yes" ]
then
  echo "Really ?? (y/n)"
  read TMP

  if [ $TMP == "y" -o $TMP == "yes" ]
  then
    LANG=C xdg-user-dirs-gtk-update 
  fi
fi


echo "#############################"
echo "# PPA"
echo "#############################"

insppa ubuntu-defaults-ja ppa:japaneseteam/ppa
insppa firefox ppa:mozillateam/firefox-next
insppa libreoffice ppa:libreoffice/ppa
insppa gimp ppa:otto-kesselgulasch/gimp
insppa virtualbox ppa:debfx/virtualbox

if [ `echo "$DIST_VER >= 12.04" | bc` == 1 ]
then
  insppa indicator-multiload ppa:indicator-multiload/stable-daily
  insppa indicator-sensors ppa:alexmurray/indicator-sensors
fi

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
insfunc openssh-server
insfunc gparted
insfunc ibus-mozc
insfunc gdebi
insfunc nautilus-dropbox


echo "#############################"
echo "# RESULT"
echo "#############################"

echo "PPASTR = "
echo $PPASTR
echo ""
echo "INSSTR = "
echo $INSSTR

echo "Are you OK?? (y/n)"
read TMP


if [ $TMP == "y" -o $TMP == "yes" ]
then

  if [ $PPAFLAG == true ]
  then
    echo "PPAFLAG is true"
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
  echo "# PPA and Install Success!!"
  echo "#############################"
fi
