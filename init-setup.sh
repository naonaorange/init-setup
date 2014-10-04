#!/bin/bash

DIST_VER=`lsb_release -rs`

INSSTR=""
PPASTR=""

PPAFLAG=false

#################################
# FUNC
#################################

insFunc()
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

insPPA()
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

#insSourceslist()
#{
#  echo "Do you add sourceslist.d repository =>> $1 ? (y/n)" 
#  read TMP
#
#  if [ $TMP == "y" -o $TMP == "yes" ]
#  then
#    echo "$2" | sudo tee /etc/apt/sources.list.d/$1.list
#    INSSTR="$INSSTR $1"
#
#    if [ `echo "$# >= 3" | bc` == 1 ]
#    then
#      sh -c '$3'
#    fi
#  fi
#}

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


if [ `echo "$DIST_VER >= 14.04" | bc` == 1 ]
then
  echo "#############################"
  echo "# CapslockをCtrlとする"
  echo "#############################"

  echo "Are you OK ?? (y/n)"
  read TMP

  if [ $TMP == "y" -o $TMP == "yes" ]
  then
    echo "Really ?? (y/n)"
    read TMP

    if [ $TMP == "y" -o $TMP == "yes" ]
    then
      #Ref of https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToSetCapsLockAsCtrl
      dconf reset /org/gnome/settings-daemon/plugins/keyboard/active
      dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
    fi
  fi
fi

echo "#############################"
echo "# PPA"
echo "#############################"

insPPA ubuntu-defaults-ja ppa:japaneseteam/ppa
insPPA firefox ppa:mozillateam/firefox-next
insPPA libreoffice ppa:libreoffice/ppa
insPPA gimp ppa:otto-kesselgulasch/gimp

if [ `echo "$DIST_VER <= 12.04" | bc` == 1 ]
then
  insPPA indicator-multiload ppa:indicator-multiload/stable-daily
  insPPA indicator-sensors ppa:alexmurray/indicator-sensors
fi

#echo "#############################"
#echo "# edit the sourceslist.d"
#echo "#############################"
#insSourceslist virtualbox-4.3 "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" "wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -"


echo "#############################"
echo "# INSTALL"
echo "#############################"

insFunc vim
insFunc vim-gnome
insFunc terminator
insFunc trash-cli
insFunc synaptic
insFunc chromium-browser
insFunc midori
insFunc openssh-server
insFunc gparted
insFunc ibus-mozc
insFunc gdebi
insFunc nautilus-dropbox


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
