# Function Instalasi
INSTALL(){
    # Memulai Penginstalan 
    echo -e "\e[36mMenginstall....\e[1m"
    apt update && apt upgrade -y
    apt install neovim git nodejs clang lua-language-server -y
    cd ~ && git clone https://github.com/alwialways/myNeovim.git
    if [[ -d $HOME/.local/share/nvim/site/pack/packer ]]
    then 
        echo -e "\e[36mSetup Neovim....\e[1m"
        cp -r ~/myNeovim/nvim ~/.config
        echo -e "\e[36mSetup Berhasil\e[1m"
        nvim +PackerSync
    else
        echo -e "\e[36mMendownload Installer....\e[1m"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim
        cp -r ~/myNeovim/nvim ~/.config
        echo -e "\e[36mSetup Berhasil !\e[1m"
        nvim +PackerSync
    fi
}

function main(){
    # Cek Apakah Folder .config Ada 
    echo -e "\e[36mMengecek Folder .config....\e[1m"
    if [[ -d $HOME/.config ]]
    then 
        echo -e "\e[36mFolder ditemukan.....\e[1m"
        if [[ -d $HOME/.config/nvim ]]
        then 
            echo -e "\e[36mBackup folder nvim...\e[1m"
            mv ~/.config/nvim ~/.config/nvim.bck 
            echo -e "\e[31mFolder backup ~/.config/nvim.bck\e[1m"
            INSTALL
    	else
	    INSTALL
	fi
    else
        echo -e "\e[36mMembuat Folder .config...\e[1m"
        mkdir ~/.config 
        INSTALL
    fi
}

main
rm -rf ~/install.sh
