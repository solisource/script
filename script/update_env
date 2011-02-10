all: pc linux
pc: 
	\cp -f ../git/.gitconfig /etc/gitconfig 
	\cp -f ../git/bash_profile ~/.bashrc
	
	\cp -f ../vim/.vimrc_win /c/Program\ Files/Vim/_vimrc
linux:
	\mv  ~/.bashrc ~/.bashrc.`date +%y%m%d%H%M`
	\cp -f ../bash/.bashrc_linux ~/.bashrc
	
	\mv  ~/.vimrc ~/.vimrc.`date +%y%m%d%H%M`
	\cp -f ../vim/.vimrc_linux ~/.vimrc
  	
	
