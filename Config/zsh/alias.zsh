alias gentoo-update="su -c 'emerge-webrsync'"
alias gentoo-upgrade="su -c 'emerge -av -uDU --with-bdeps=y @world'"
alias gentoo-use-new="su -c 'emerge -av --update --newuse --deep @world'"
alias spegni="su -c 'shutdown -h now'"
alias connect="su -c '/etc/init.d/net.wlp2s0 start'"
alias copy="xclip -f -sel clip"
alias paste="xclip -o -sel clip"
alias scrotF="scrot -b -d 5 ~/Pictures/%b%d::%H%M%S.png"
#alias ubuntu="VBoxManage startvm 'Lubuntu14.04' --type gui"
#alias Arch="VBoxManage startvm 'Arch' --type gui"
alias display="xrandr --output HDMI1 --auto && xrandr --output eDP1 --off"
alias nodisplay="xrandr --output HDMI1 --off && xrandr --output eDP1 --auto"
alias reboot="su -c 'reboot'"
alias uranger="urxvt -e ranger"
alias scrubs="su -c 'btrfs scrub start /'"
alias old_root="su -c 'mount UUID=6792A3A8-6E5F-470A-8807-45CCB0140AD0 \
                /mnt/ROOT_old'"
alias layit="su -c 'setxkbmap it'"
alias layus="su -c 'setxkbmap us'"
alias dualdisp="xrandr --output eDP1 --left-of HDMI1 --auto; feh --bg-scale ~/Pictures/gruvbox.png --bg-scale ~/Pictures/gruvbox.png"
alias backup="su -c 'exec btrbk -q -c /etc/btrbk/btrbk-laptop.conf run'"
alias backup2="su -c '/home/enrico/.bin/BtrbkBackUp'"
alias finish="su -c 'cat /var/log/syslog'"
alias cgvim="gvim /home/enrico/Git/Vim_config/gvim/vimrc"