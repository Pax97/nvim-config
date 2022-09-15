#!/bin/bash
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Reset='\033[0m'	
declare -a PKG_NEEDED
echo "Checking requirement..."
sleep 1
checking_pakage_installed()
{
  echo -e ${Yellow}+  Checking Requirement  +${Reset};
  REQUIRED_PKG=$1
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG 2> /dev/null|grep "install ok installed")
  if [ "install ok installed" = "$PKG_OK" ]; then
    echo -e Checking for $REQUIRED_PKG: "${Green}Installed${Reset}"
  else
    echo -e Checking for $REQUIRED_PKG: "${Red}Not Installed${Reset}"
	  PKG_NEEDED+=($REQUIRED_PKG)
  fi 
}
checking_pakage_installed python3
checking_pakage_installed python3-pip
checking_pakage_installed nodejs

install_lost_package(){
  echo ${PKG_NEEDED[*]}
  for i in "${PKG_NEEDED[@]}"
  do
	case $i in
	    python3 ) 
          echo -e ${Yellow}+    Install python3    +${Reset};
		      sudo apt install --yes python3;
		            ;;
	    python3-pip )
          echo -e ${Yellow}+    Install PIP    +${Reset};
		      sudo apt install --yes python3-pip
		            ;;
	    nodejs ) 
          echo -e ${Yellow}+    Install Node-JS    +${Reset};
		      sudo apt install --yes curl;
		      curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -;
		      sudo apt-get install -y nodejs;
		            ;;

	esac
  done
}

install_third_party(){
  echo -e ${Yellow}Install npm package...${Reset}
  sudo npm install -g typescript typescript-language-server pyright neovim prettier
  echo -e ${Yellow}Install pip package...${Reset}
  pip install autopep8 && pip install --upgrade pynvim
}

install_nvim_config(){
  OS_TYPE=$(dpkg --print-architecture)
  echo -e ${Green}Detect your CPU is $OS_TYPE ${Reset}
  case $OS_TYPE in
	  amd64 ) sudo apt install --yes curl;
		  sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb;
		  sudo apt install ./nvim-linux64.deb;
		  mkdir -p ~/.config;
		  cp -r nvim ~/.config/nvim;
      echo "Install Complete!"
		  ;;
	  arm64 ) sudo apt update;
		  sudo apt-get install --yes ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen;
		  git clone https://github.com/neovim/neovim;
		  cd neovim && git checkout stable;
		  make CMAKE_BUILD_TYPE=Release;
		  sudo make install;
		  mkdir -p ~/.config;
		  cd .. && cp -r nvim ~/.config/nvim;
		  echo "Install Complete!"
		  ;;
  esac
}

if [ ${#PKG_NEEDED[@]} -eq 0 ]
then
  install_third_party;
  install_nvim_config;
else
  while true; do
  read -p "Do you want to automatically install lost package? (y/n) " yn
  case $yn in 
    [yY] ) install_lost_package && install_third_party && install_nvim_config;
    	break;;
    * ) echo Exiting...;
   	  exit;;
  esac
  done
fi
