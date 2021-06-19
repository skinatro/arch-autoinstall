# arch-autoinstall

A script that auto installs arch onto my laptop , installs all the packages I usually use and also restores all the config files and themes according to my choice.

```
wget https://raw.githubusercontent.com/skinatro/arch-autoinstall/main/install_script.sh
chmod +x install_script.sh
./install_script.sh
```

# Install_script.sh

To use this curl or wget the install_script.sh ,give it executable perms by chmod +x ,it should install the necessary packages and "hopefully" properly setup arch(I plan to try this inside vm {with few packages changed}),

it should also download the post_install.sh and config_install.sh scripts as well

# post_install.sh

Installs the programs I want and activates their services and other setup commands required

# config_install.sh 

Restores the config files for most of the programs and themes it according to the theme. It will be available at this [repo] (https://github.com/skinatro/dotfiles)  

* I haven't created the repo yet , so the link will be broken 

## License

This script is licensed under GPLv2.0
