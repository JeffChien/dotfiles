

# prepare user and group
```.sh
sudo groupadd --system uinput
sudo useradd --system --no-create-home --groups input,uinput --shell /bin/false --user-group kanata
sudo usermod -aG uinput kanata
sudo usermod -aG input kanata
```

the **uinput** must be a system group


# udev rule
the default owner and group are both root, this udev change the group and permission of the file `/dev/uninput` after modprobe

```.sh
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/50-kanata.rules >/dev/null
```

# config and systemd service
