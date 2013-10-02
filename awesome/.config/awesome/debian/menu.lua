-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_應用程式_Shells"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
	{"Zsh", "x-terminal-emulator -e ".."/bin/zsh4"},
}
Debian_menu["Debian_應用程式_文字"] = {
	{"Fortune","sh -c 'while /usr/games/fortune | col -x | xmessage -center -buttons OK:1,Another:0 -default OK -file - ; do :; done'"},
}
Debian_menu["Debian_應用程式_檔案管理"] = {
	{"K3b","/usr/bin/k3b","/usr/share/pixmaps/k3b.xpm"},
}
Debian_menu["Debian_應用程式_檢視器"] = {
	{"digikam","/usr/bin/digikam"},
	{"Evince","/usr/bin/evince","/usr/share/pixmaps/evince.xpm"},
	{"Xditview","xditview"},
}
Debian_menu["Debian_應用程式_科學_數學"] = {
	{"Bc", "x-terminal-emulator -e ".."/usr/bin/bc"},
	{"Dc", "x-terminal-emulator -e ".."/usr/bin/dc"},
	{"LibreOffice Math","/usr/bin/libreoffice --math","/usr/share/icons/hicolor/32x32/apps/libreoffice-math.xpm"},
	{"Xcalc","xcalc"},
}
Debian_menu["Debian_應用程式_科學"] = {
	{ "數學", Debian_menu["Debian_應用程式_科學_數學"] },
}
Debian_menu["Debian_應用程式_系統_套件管理"] = {
	{"Aptitude Package Manager (text)", "x-terminal-emulator -e ".."/usr/bin/aptitude-curses"},
	{"Synaptic Package Manager","synaptic-pkexec","/usr/share/synaptic/pixmaps/synaptic_32x32.xpm"},
}
Debian_menu["Debian_應用程式_系統_監控程式"] = {
	{"Pstree", "x-terminal-emulator -e ".."/usr/bin/pstree.x11","/usr/share/pixmaps/pstree16.xpm"},
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xconsole","xconsole -file /dev/xconsole"},
	{"Xev","x-terminal-emulator -e xev"},
	{"Xload","xload"},
}
Debian_menu["Debian_應用程式_系統_硬體"] = {
	{"Windows Wireless Drivers","su-to-root -X -c /usr/sbin/ndisgtk","/usr/share/pixmaps/ndisgtk.xpm"},
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_應用程式_系統_管理工具"] = {
	{"Debian Task selector", "x-terminal-emulator -e ".."su-to-root -c tasksel"},
	{"DSL/PPPoE configuration tool", "x-terminal-emulator -e ".."/usr/sbin/pppoeconf","/usr/share/pixmaps/pppoeconf.xpm"},
	{"Editres","editres"},
	{"pppconfig", "x-terminal-emulator -e ".."su-to-root -p root -c /usr/sbin/pppconfig"},
	{"Xclipboard","xclipboard"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
	{"Control Center","gnome-control-center"},
}
Debian_menu["Debian_應用程式_系統_語言環境"] = {
	{"gcin","/usr/bin/gcin","/usr/share/pixmaps/gcin.xpm"},
	{"gcin-tools","/usr/bin/gcin-tools","/usr/share/pixmaps/gcin.xpm"},
	{"Input Method Swicher", "x-terminal-emulator -e ".."/usr/bin/im-switch"},
}
Debian_menu["Debian_應用程式_系統"] = {
	{ "套件管理", Debian_menu["Debian_應用程式_系統_套件管理"] },
	{ "監控程式", Debian_menu["Debian_應用程式_系統_監控程式"] },
	{ "硬體", Debian_menu["Debian_應用程式_系統_硬體"] },
	{ "管理工具", Debian_menu["Debian_應用程式_系統_管理工具"] },
	{ "語言環境", Debian_menu["Debian_應用程式_系統_語言環境"] },
}
Debian_menu["Debian_應用程式_終端機模擬器"] = {
	{"Gnome Terminal","/usr/bin/gnome-terminal","/usr/share/pixmaps/gnome-terminal.xpm"},
	{"YaKuake","/usr/bin/yakuake"},
}
Debian_menu["Debian_應用程式_網路_檔案傳輸"] = {
	{"KTorrent","ktorrent","/usr/share/pixmaps/ktorrent.xpm"},
}
Debian_menu["Debian_應用程式_網路_網頁瀏覽"] = {
	{"ELinks WWW browser", "x-terminal-emulator -e ".."/usr/bin/elinks"},
	{"Epiphany web browser","/usr/bin/epiphany-browser"},
	{"Lynx-cur", "x-terminal-emulator -e ".."lynx"},
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_應用程式_網路_通訊"] = {
	{"kvpnc","su-to-root -X -c kvpnc"},
	{"Telnet", "x-terminal-emulator -e ".."/usr/bin/telnet"},
	{"Xbiff","xbiff"},
}
Debian_menu["Debian_應用程式_網路"] = {
	{ "檔案傳輸", Debian_menu["Debian_應用程式_網路_檔案傳輸"] },
	{ "網頁瀏覽", Debian_menu["Debian_應用程式_網路_網頁瀏覽"] },
	{ "通訊", Debian_menu["Debian_應用程式_網路_通訊"] },
}
Debian_menu["Debian_應用程式_辨公室"] = {
	{"LibreOffice Calc","/usr/bin/libreoffice --calc","/usr/share/icons/hicolor/32x32/apps/libreoffice-calc.xpm"},
	{"LibreOffice Impress","/usr/bin/libreoffice --impress","/usr/share/icons/hicolor/32x32/apps/libreoffice-impress.xpm"},
	{"LibreOffice Writer","/usr/bin/libreoffice --writer","/usr/share/icons/hicolor/32x32/apps/libreoffice-writer.xpm"},
}
Debian_menu["Debian_應用程式_音效"] = {
	{"Amarok","/usr/bin/amarok"},
}
Debian_menu["Debian_應用程式"] = {
	{ "Shells", Debian_menu["Debian_應用程式_Shells"] },
	{ "文字", Debian_menu["Debian_應用程式_文字"] },
	{ "檔案管理", Debian_menu["Debian_應用程式_檔案管理"] },
	{ "檢視器", Debian_menu["Debian_應用程式_檢視器"] },
	{ "科學", Debian_menu["Debian_應用程式_科學"] },
	{ "系統", Debian_menu["Debian_應用程式_系統"] },
	{ "終端機模擬器", Debian_menu["Debian_應用程式_終端機模擬器"] },
	{ "網路", Debian_menu["Debian_應用程式_網路"] },
	{ "辨公室", Debian_menu["Debian_應用程式_辨公室"] },
	{ "音效", Debian_menu["Debian_應用程式_音效"] },
}
Debian_menu["Debian_求助"] = {
	{"Info", "x-terminal-emulator -e ".."info"},
	{"Xman","xman"},
	{"yelp","/usr/bin/yelp"},
}
Debian_menu["Debian_遊戲_玩具"] = {
	{"Oclock","oclock"},
	{"Xclock (analog)","xclock -analog"},
	{"Xclock (digital)","xclock -digital -update 1"},
	{"Xeyes","xeyes"},
	{"Xlogo","xlogo"},
}
Debian_menu["Debian_遊戲"] = {
	{ "玩具", Debian_menu["Debian_遊戲_玩具"] },
}
Debian_menu["Debian"] = {
	{ "應用程式", Debian_menu["Debian_應用程式"] },
	{ "求助", Debian_menu["Debian_求助"] },
	{ "遊戲", Debian_menu["Debian_遊戲"] },
}
