
update-in:
	\cp -rf /etc/rc.local ./bashrc.rc.local
	\cp -rf /ecad/bashrc.ecad ./bashrc.ecad
	\cp -rf /ecad/bashrc.alias ./bashrc.alias

update-to:
	\cp -rf bashrc.rc.local /etc/rc.local
	\cp -rf bashrc.ecad /ecad/bashrc.ecad
	\cp -rf bashrc.alias /ecad/bashrc.alias

