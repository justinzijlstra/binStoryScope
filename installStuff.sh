#!/bin/bash

user="${SUDO_USER:-${USER}}"

#clear
sudo rm /etc/systemd/jzcam.service
sudo rm /home/camm.sh
sudo rm /home/shutdown.sh
sudo rm /home/storyScope.sh
sudo rm /home/$user/.config/autostart/runStoryScope.desktop
sudo rm /home/$user/.config/autostart/runReactivision.desktop

#create
sudo touch /etc/systemd/jzcam.service
sudo touch /home/camm.sh
sudo touch /home/shutdown.sh
sudo touch /home/storyScope.sh

sudo touch /home/$user/.config/autostart/runStoryScope.desktop
sudo touch /home/$user/.config/autostart/runReactivision.desktop

pathS=/home/$user/.config/autostart/runStoryScope.desktop
pathR=/home/$user/.config/autostart/runReactivision.desktop

sudo mkdir /home/InteractiveCulture
sudo chmod 777 /home/InteractiveCulture

#service
sudo echo "[Unit]" >> /etc/systemd/jzcam.service
sudo echo "Description = runs camera clone script" >> /etc/systemd/jzcam.service
sudo echo "[Service]" >> /etc/systemd/jzcam.service
sudo echo "ExecStart=/home/camm.sh" >> /etc/systemd/jzcam.service
sudo echo "[Install]" >> /etc/systemd/jzcam.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/jzcam.service

#cam
sudo echo "#!/bin/bash" >> /home/camm.sh
sudo echo "v4l2-ctl -d /dev/video0 --set-fmt-video=width=1280,height=720,pixelformat=H264" >>/home/camm.sh
sudo echo 'sudo modprobe v4l2loopback video_nr=2 card_label="device2"' >> /home/camm.sh
sudo echo "ffmpeg -f video4linux2 -i /dev/video0 -codec copy -f v4l2 /dev/video2" >> /home/camm.sh

#shutdown
sudo echo "#!/bin/bash" >> /home/shutdown.sh
sudo echo "shutdown -h 0" >> /home/shutdown.sh

#make executable
sudo echo "#!/bin/bash" >> /home/storyScope.sh
sudo echo "sudo find /home/InteractiveCulture/Builds -type f -exec chmod 755 {} +" >> /home/storyScope.sh
#TODO waar runt storyScope.sh????????????????????????????????????????????????????????????

#reactivision startup
sudo echo "[Desktop Entry]" >> $pathR
sudo echo "Type=Application" >> $pathR
sudo echo "Exec=/bin/reacTIVision" >> $pathR
sudo echo "Hidden=false" >> $pathR
sudo echo "NoDisplay=false" >> $pathR
sudo echo "X-GNOME-Autostart-enabled=true" >> $pathR
sudo echo "Name[en_US]=reacTIVision" >> $pathR
sudo echo "Name=reacTIVision" >> $pathR
sudo echo "Comment[en_US]=" >> $pathR
sudo echo "Comment=" >> $pathR

#storyscope startup
sudo echo "[Desktop Entry]" >> $pathS
sudo echo "Type=Application" >> $pathS
sudo echo 'Exec=bash -c "sleep 5 && /home/InteractiveCulture/Builds/Silhouette_Light/StoryScope.x86_64"' >> $pathS
sudo echo "Hidden=false" >> $pathS
sudo echo "NoDisplay=false" >> $pathS
sudo echo "X-GNOME-Autostart-enabled=true" >> $pathS
sudo echo "Name[en_US]=StoryScope" >> $pathS
sudo echo "Name=StoryScope" >> $pathS
sudo echo "Comment[en_US]=" >> $pathS
sudo echo "Comment=" >> $pathS

#permissions
sudo systemctl enable /etc/systemd/jzcam.service
sudo chmod +x /home/camm.sh
sudo chmod +x /home/shutdown.sh
sudo chmod 777 /home/InteractiveCulture


