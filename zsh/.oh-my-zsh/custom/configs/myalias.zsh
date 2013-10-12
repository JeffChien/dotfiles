alias simg="feh --auto-zoom --scale-down"

alias op="xdg-open"
alias optype="xdg-mime query filetype"
alias opby="xdg-mime query default"

alias cp="rsync --progress -ah"

#hightlight pattern with front color red
alias hlf-r='ack-grep --passthru --color-match=red'
#hightlight pattern with front color green
alias hlf-g='ack-grep --passthru --color-match=green'
#hightlight pattern with front color blue
alias hlf-b='ack-grep --passthru --color-match=blue'
#hightlight pattern with front color yellow
alias hlf-y='ack-grep --passthru --color-match=yellow'
#hightlight pattern with background color red
alias hlb-r='ack-grep --passthru --color-match=on_red'
#hightlight pattern with background color green
alias hlb-g='ack-grep --passthru --color-match=on_green'
#hightlight pattern with background color blue
alias hlb-b='ack-grep --passthru --color-match=on_blue'
#hightlight pattern with background color yellow
alias hlb-y='ack-grep --passthru --color-match=on_yellow'
#only show not matched line
alias blind='ack-grep -v'

# android {{{
#adb shell
alias adbshell='adb wait-for-device; adb shell'
#show android kernel message
alias adbkmsg='adb wait-for-device && adb shell "cat /proc/kmsg"'
alias adbcat='adb wait-for-device && adb logcat'
#show android event device
alias aevent='adb wait-for-device && adb shell "getevent"'
#flash android boot partition withought signature
alias flashboot-nosig='adb wait-for-device && adb reboot-bootloader && fastboot flash boot boot.img && fastboot reboot'
#make phone into qualcomm dload mode
alias adload='adb wait-for-device;adb shell "echo 1 > /sys/module/restart/parameters/download_mode";adb shell "echo 'c' > /proc/sysrq-trigger"'
#make phone crash and restart without enter dload mode
alias acrash='adb wait-for-device;adb shell "echo 0 > /sys/module/restart/parameters/download_mode";adb shell "echo 'c' > /proc/sysrq-trigger"'

alias akmsg='adbtool log kmsg'
alias admesg='adbtool log dmesg'
alias adebug='adbtool debugfs'
alias ffb='fastboot flash boot'
alias ffu='fastboot flash userdata'
alias ffs='fastboot flash system'
alias ffc='fastboot flash cache'
alias aboot='adb wait-for-device reboot bootloader'
alias frb='fastboot reboot'
# }}}

alias psudo='sudo env PATH=$PATH'
