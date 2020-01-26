#!/bin/bash
EDITOR=nano
PASSWD=/etc/passwd
RED=`tput setaf 1`
GREEN=`tput setaf 2`

BG_CYAN=`tput setab 6`
BG_WHITE=`tput setab 7`
RESET=`tput sgr0`
 
pause(){
  read -p "Press [Enter] to return to the main menu..." fackEnterKey
}
 
one(){
  DIR=~/klipper
  SERV=/etc/init.d/klipper
  if [  -d "$DIR" ]; then
    echo "KLIPPER is installed!"
    sleep 2
  else
    echo "KLIPPER is NOT installed!"
    cd ~/
    echo "Cloning the KLIPPER folder From GITHUB..."
    sleep 2
    git clone https://github.com/KevinOConnor/klipper.git
    
    sleep 2 
  
    while true
    do
      clear
      echo '
       ____  __..____     .___ __________ __________ _____________________    ____    ________    __      __ _________  ________   __________ _________  _________
      |    |/ _||    |    |   |\______   \\______   \\_   _____/\______   \  /  _ \   \______ \  /  \    /  \\_   ___ \ \_____  \  \______   \\_   ___ \ \______  \
      |      <  |    |    |   | |     ___/ |     ___/ |    __)_  |       _/  >  _ </\  |    |  \ \   \/\/   //    \  \/  /  ____/   |       _//    \  \/     /    /
      |    |  \ |    |___ |   | |    |     |    |     |        \ |    |   \ /  <_\ \/  |    `   \ \        / \     \____/       \   |    |   \\     \____   /    /
      |____|__ \|_______ \|___| |____|     |____|    /_______  / |____|_  / \_____\ \ /_______  /  \__/\  /   \______  /\_______ \  |____|_  / \______  /  /____/
              \/        \/                                   \/         \/         \/         \/        \/           \/         \/         \/         \/
      .___                   __           .__   .__      ____                       .___          __
      |   |  ____    _______/  |_ _____   |  |  |  |    /  _ \    __ __ ______    __| _/_____   _/  |_   ____
      |   | /    \  /  ___/\   __\\__  \  |  |  |  |    >  _ </\ |  |  \\____ \  / __ | \__  \  \   __\_/ __ \
      |   ||   |  \ \___ \  |  |   / __ \_|  |__|  |__ /  <_\ \/ |  |  /|  |_> >/ /_/ |  / __ \_ |  |  \  ___/
      |___||___|  //____  > |__|  (____  /|____/|____/ \_____\ \ |____/ |   __/ \____ | (____  / |__|   \___  >
                \/      \/             \/                     \/        |__|         \/      \/             \/
      __________             _____                          _________ .__         .__
      \______   \ ___.__.   /     \  _____     ____   __ __ \______  \|__|_______ |  |
       |    |  _/<   |  |  /  \ /  \ \__  \   /    \ |  |  \    /    /|  |\_  __ \|  |
       |    |   \ \___  | /    Y    \ / __ \_|   |  \|  |  /   /    / |  | |  | \/|  |__
       |______  / / ____| \____|__  /(____  /|___|  /|____/   /____/  |__| |__|   |____/
              \/  \/              \/      \/      \/
      '
      echo "Running the install service script for your SOC"
      cd ~/klipper/scripts
      array=($(ls . | grep install-))
      cat << EOF
 
      =================================
      KLIPPER SERVICE INSTALL FOR SOC:
      ---------------------------------
      Please choose the install needed:
      (1)${array[0]}
      (2)${array[1]}
      (3)${array[2]}
      (4)${array[3]}
      (Q)uit
      ---------------------------------
EOF
 
      read -n1 -s
      case "$REPLY" in
        "1")  ./${array[0]}
        break ;;
        "2")  ./${array[1]}
        break ;;
        "3")  ./${array[2]}
        break ;;
        "4")  ./${array[3]}
        break ;;
        "Q") break ;;
        "q") echo "case sensitive!!"  ;;
        *  ) echo "invalid option" ;;
 
      esac
      sleep 1
    done
fi
pause
}
 
 
 
two(){
echo "Stopping KLIPPER service..."
sudo systemctl stop klipper
cd ~/klipper
echo "Copying KLIPPER folder to klipper_backup, just in case..."
sleep 2
cp -avr ~/klipper/ ~/klipper_backup
echo "Updating the KLIPPER folder from github..."
git pull
echo "KLIPPER is up to date!"
sleep 2
echo "You may need to reflash your MCU for the changes to take effect"
sleep 3
echo "Restarting KLIPPER service"
sudo systemctl start klipper
pause
}
 
 
 
three(){
echo "Stopping KLIPPER service..."
sudo systemctl stop klipper
cd ~/klipper
echo "Creating a new micro firmware for the MCU"
make clean
echo "Opening menuconfig, choose your MCU type, then choose exit"
make menuconfig
echo "Compiling the micro firmware..."
sleep 2
make
echo "The firmware is ready! You also found it at ~/klipper/src/klipper.elf.hex or ~/klipper/out/klipper.bin"
sleep 3
while true
  do
    clear
    echo '
     ____  __..____     .___ __________ __________ _____________________    ____    ________    __      __ _________  ________   __________ _________  _________
    |    |/ _||    |    |   |\______   \\______   \\_   _____/\______   \  /  _ \   \______ \  /  \    /  \\_   ___ \ \_____  \  \______   \\_   ___ \ \______  \
    |      <  |    |    |   | |     ___/ |     ___/ |    __)_  |       _/  >  _ </\  |    |  \ \   \/\/   //    \  \/  /  ____/   |       _//    \  \/     /    /
    |    |  \ |    |___ |   | |    |     |    |     |        \ |    |   \ /  <_\ \/  |    `   \ \        / \     \____/       \   |    |   \\     \____   /    /
    |____|__ \|_______ \|___| |____|     |____|    /_______  / |____|_  / \_____\ \ /_______  /  \__/\  /   \______  /\_______ \  |____|_  / \______  /  /____/
            \/        \/                                   \/         \/         \/         \/        \/           \/         \/         \/         \/
    .___                   __           .__   .__      ____                       .___          __
    |   |  ____    _______/  |_ _____   |  |  |  |    /  _ \    __ __ ______    __| _/_____   _/  |_   ____
    |   | /    \  /  ___/\   __\\__  \  |  |  |  |    >  _ </\ |  |  \\____ \  / __ | \__  \  \   __\_/ __ \
    |   ||   |  \ \___ \  |  |   / __ \_|  |__|  |__ /  <_\ \/ |  |  /|  |_> >/ /_/ |  / __ \_ |  |  \  ___/
    |___||___|  //____  > |__|  (____  /|____/|____/ \_____\ \ |____/ |   __/ \____ | (____  / |__|   \___  >
              \/      \/             \/                     \/        |__|         \/      \/             \/
    __________             _____                          _________ .__         .__
    \______   \ ___.__.   /     \  _____     ____   __ __ \______  \|__|_______ |  |
     |    |  _/<   |  |  /  \ /  \ \__  \   /    \ |  |  \    /    /|  |\_  __ \|  |
     |    |   \ \___  | /    Y    \ / __ \_|   |  \|  |  /   /    / |  | |  | \/|  |__
     |______  / / ____| \____|__  /(____  /|___|  /|____/   /____/  |__| |__|   |____/
            \/  \/              \/      \/      \/
    '
    cat << EOF
 
    =================================
    KLIPPER MICRO FIRMWARE FLASHING:
    ---------------------------------
    Please choose the method needed:
    (1)Flash your MCU via serial USB
    (2)Flash your MCU via SDCARD
    (Q)uit
    ---------------------------------
EOF
  read -n1 -s
    case "$REPLY" in
      "1")  echo "Flashing the MCU with the new compiled micro firmware..."
            sleep 3
            echo "Please connect your MCU to the SOC via USB cable"
            read -n 1 -s -r -p "Press any key to continue"
            mcu_add=$(ls -A /dev/serial/by-id/)
                if [ $? != 0 ]; then
                  echo "Please plug in your MCU via USB cable, prior trying to flash it!"
                  sleep 3
                else
                echo "Flashing your MCU..."
                if [ $(ls -A ~/klipper/flash.log) ]; then
                rm ~/klipper/flash.log
                fi
                make flash FLASH_DEVICE=/dev/serial/by-id/$mcu_add | tee flash.log
                fi
                if [ -s ~/klipper/flash.log ]; then
                  echo "Your MCU is flashed now"
                  sleep 2
                else
                  echo "You may have encountered a problem! Check your USB connection and try to flash it again..."
                  sleep 2
                fi
                echo "Restarting KLIPPER service"
                sudo systemctl start klipper
                sleep 3
                break ;;
 
      "2")  echo "Stopping KLIPPER service..."
            sudo systemctl stop klipper
            cd ~/klipper
            echo "Renaming the klipper.elf.hex to firmware.bin..."
            cp -v ~/klipper/out/klipper.bin ~/klipper/out/firmware.bin
            echo "Please insert an SDCARD (min. 128MB)..."
            read -n 1 -s -r -p "Press any key to continue"
            check_sdcard=$(ls -A /dev/sda)
            if [ $? == 0 ]; then
              echo "mounting the SDCARD to /mnt/ "
              sudo mount /dev/sda1 /mnt/
              echo "Moving the micro firmware to the SDCARD..."
              sudo rsync -va --no-owner --no-group --remove-source-files ~/klipper/out/firmware.bin /mnt/
              ls -A /mnt/firmware.bin
              sleep 2
              echo "Unmounting the SDCARD..."
              sudo umount /mnt/
              echo "Now insert the SDCARD into your MCU, power it on and press the reset button"
              sleep 3
              echo "Congrats you just flashed your MCU!"
              sleep 2
            else
              echo "Your SDCARD is not connected!"
              sleep 3
            fi
            echo "Restarting KLIPPER service"
            sudo systemctl start klipper
            sleep 3
            pause ;;
      "Q") break ;;
      "q") echo "case sensitive!!" ;;
      *) echo "invalid option" ;;
      esac
      sleep 1
      done
      pause
  }
 
 
four(){
cd ~
echo "Stopping KLIPPER service..."
sudo systemctl stop klipper
DIR=~/klipper
SERV=/etc/init.d/klipper
if [ -d "$DIR" ] && [ -s "$SERV" ]; then
  echo "Cleaning old klipper_backup folder, if any..."
  sleep 2
  rm -fR klipper_backup
  echo "Copying KLIPPER to a backup folder for klipper, at ~/klipper_backup..."
  sleep 2
  cp -avr klipper klipper_backup
  echo "Adding some magic to make dwc2-for-klipper to work..."
  PYTHONDIR="${HOME}/klippy-env"
  virtualenv ${PYTHONDIR}
  ${PYTHONDIR}/bin/pip2 install tornado==5.1.1
  echo "Cloning the dwc2-for-klipper folder from Stephan3 GITHUB..."
  git clone https://github.com/Stephan3/dwc2-for-klipper.git
  echo "Connecting dwc2-for-klipper as an extra module for klippy -> web_dwc2.py..."
  web_dwc2=~/klipper/klippy/extras/web_dwc2.py
  if [ -s "$web_dwc2" ]; then
    echo "$dwc2_module is already linked to KLIPPY"
    sleep 2
  else
    user=$(whoami)
    ln -s ~/dwc2-for-klipper/web_dwc2.py ~/klipper/klippy/extras/web_dwc2.py
    chown -h $user:$user  ~/klipper/klippy/extras/web_dwc2.py
    dwc2_module=$(ls -A ~/klipper/klippy/extras | grep -woh web_dwc2.py)
    echo "$dwc2_module is linked to KLIPPY"
    sleep 2
  fi
  echo "Backup for ~/klipper/klippy/gcode.py file"
  sleep 2
  cp -av ~/klipper/klippy/gcode.py ~/klipper/klippy/gcode.py_backup
  echo "Doing some more magic... Correcting some stuff in ~/klipper/klippy/gcode.py"
  sleep 2
  # make changes in klipper we need
  gcode=$(sed 's/self.bytes_read = 0/self.bytes_read = 0\n        self.respond_callbacks = []/g' klipper/klippy/gcode.py)
  gcode=$(echo "$gcode" | sed 's/# Response handling/def register_respond_callback(self, callback):\n        self.respond_callbacks.append(callback)/')
  gcode=$(echo "$gcode" | sed 's/os.write(self.fd, msg+"\\n")/os.write(self.fd, msg+"\\n")\n            for callback in self.respond_callbacks:\n                callback(msg+"\\n")/')
  echo "$gcode" > klipper/klippy/gcode.py
  echo "Creating a folder for nesting the DuetWebControl UI files"
  rm -Rf ~/sdcard/dwc2/web
  mkdir -p ~/sdcard/dwc2/web
  echo "Downloading the official new DWC2 RC7, from Chrishamm GITHUB..."
  cd ~/sdcard/dwc2/web
  wget https://github.com/chrishamm/DuetWebControl/releases/download/2.0.6/DuetWebControl-SBC.zip
  echo "unzip the hell out of it..."
  unzip *.zip && for f_ in $(find . | grep '.gz');do gunzip ${f_};done
  echo "Installation done! Congrats!"
  sleep 2
  echo "Do not forget to add a [virtual_sdcard] and a [web_dwc2] sections, in your printer.cfg file, as describe in Stephan3 GITHUB"
  sleep 5
  echo "restarting the KLIPPER service"
  sudo systemctl start klipper
  sleep 3
  echo "Displaying the KLIPPY LOG file, to check that everything is OK"
  sleep 2
  tail /tmp/klippy.log
  sleep 10
else
  echo "Klipper is not install please install it first!"
  sleep 2
fi
pause
}
 
five(){
  cd ~/dwc2-for-klipper
  git pull
  echo "Reconnecting dwc2-for-klipper as an extra module for klippy..."
  rm ~/klipper/klippy/extras/web_dwc2.py
  ln -s ~/dwc2-for-klipper/web_dwc2.py ~/klipper/klippy/extras/web_dwc2.py
  echo "Doing some more magic... Correcting some stuff in ~/klipper/klippy/gcode.py"
  sleep 2
  # make changes in klipper we need
  gcode=$(sed 's/self.bytes_read = 0/self.bytes_read = 0\n        self.respond_callbacks = []/g' klipper/klippy/gcode.py)
  gcode=$(echo "$gcode" | sed 's/# Response handling/def register_respond_callback(self, callback):\n        self.respond_callbacks.append(callback)/')
  gcode=$(echo "$gcode" | sed 's/os.write(self.fd, msg+"\\n")/os.write(self.fd, msg+"\\n")\n            for callback in self.respond_callbacks:\n                callback(msg+"\\n")/')
  echo "$gcode" > klipper/klippy/gcode.py
  echo "removing the old web folder for DWC2..."
  rm -fR ~/sdcard/dwc2/web
  echo "Creating a new folder for it..."
  mkdir ~/sdcard/dwc2/web
  echo "Downloading the official new DWC2 RC7, from Chrishamm GITHUB..."
  cd ~/sdcard/dwc2/web
  rm *.zip
  wget https://github.com/chrishamm/DuetWebControl/releases/download/2.0.6/DuetWebControl-SBC.zip
  echo "unzip the hell out of it..."
  unzip *.zip && for f_ in $(find . | grep '.gz');do gunzip ${f_};done
  rm *.zip
  echo "Installation done! Congrats!"
  sleep 2
  echo "Do not forget to add a [virtual_sdcard] and a [web_dwc2] sections, in your printer.cfg file, as describe in Stephan3 GITHUB"
  sleep 5
  echo "restarting the KLIPPER service"
  sudo systemctl start klipper
  sleep 2
  echo "Displaying the KLIPPY LOG file, to check that everything is OK"
  tail /tmp/klippy.log
  sleep 1
  tail /tmp/klippy.log
  sleep 10
  pause
}
 
# function to display menus
show_menus() {
  clear
  echo '
   ____  __..____     .___ __________ __________ _____________________    ____    ________    __      __ _________  ________   __________ _________  _________
  |    |/ _||    |    |   |\______   \\______   \\_   _____/\______   \  /  _ \   \______ \  /  \    /  \\_   ___ \ \_____  \  \______   \\_   ___ \ \______  \
  |      <  |    |    |   | |     ___/ |     ___/ |    __)_  |       _/  >  _ </\  |    |  \ \   \/\/   //    \  \/  /  ____/   |       _//    \  \/     /    /
  |    |  \ |    |___ |   | |    |     |    |     |        \ |    |   \ /  <_\ \/  |    `   \ \        / \     \____/       \   |    |   \\     \____   /    /
  |____|__ \|_______ \|___| |____|     |____|    /_______  / |____|_  / \_____\ \ /_______  /  \__/\  /   \______  /\_______ \  |____|_  / \______  /  /____/
          \/        \/                                   \/         \/         \/         \/        \/           \/         \/         \/         \/
  .___                   __           .__   .__      ____                       .___          __
  |   |  ____    _______/  |_ _____   |  |  |  |    /  _ \    __ __ ______    __| _/_____   _/  |_   ____
  |   | /    \  /  ___/\   __\\__  \  |  |  |  |    >  _ </\ |  |  \\____ \  / __ | \__  \  \   __\_/ __ \
  |   ||   |  \ \___ \  |  |   / __ \_|  |__|  |__ /  <_\ \/ |  |  /|  |_> >/ /_/ |  / __ \_ |  |  \  ___/
  |___||___|  //____  > |__|  (____  /|____/|____/ \_____\ \ |____/ |   __/ \____ | (____  / |__|   \___  >
            \/      \/             \/                     \/        |__|         \/      \/             \/
  __________             _____                          _________ .__         .__
  \______   \ ___.__.   /     \  _____     ____   __ __ \______  \|__|_______ |  |
   |    |  _/<   |  |  /  \ /  \ \__  \   /    \ |  |  \    /    /|  |\_  __ \|  |
   |    |   \ \___  | /    Y    \ / __ \_|   |  \|  |  /   /    / |  | |  | \/|  |__
   |______  / / ____| \____|__  /(____  /|___|  /|____/   /____/  |__| |__|   |____/
          \/  \/              \/      \/      \/
  '
 
    echo "====================="
  echo "  INSTALL OR UPDATE  "
    echo " KLIPPER & DWC2 MENU "
    echo "====================="
    echo "1. Install KLIPPER"
    echo "2. Update KLIPPER"
  echo "3. Flash your MCU"
  echo "4. Install DWC2"
  echo "5. Update DWC2"
    echo "6. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
    local choice
    read -p "Please choose what to do, then press [ENTER] [ 1 - 6] " choice
    case $choice in
        1) one ;;
        2) two ;;
    3) three ;;
    4) four ;;
    5) five ;;
    6) exit 0 ;;
        *) echo -e "${RED}${BG_WHITE}Error...${RESET}" && sleep 2
    esac
}
 
trap '' SIGINT SIGQUIT SIGTSTP
 
while true
do
 
    show_menus
    read_options
done
