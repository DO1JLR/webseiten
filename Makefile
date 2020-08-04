all: update

.ONESHELL:
install:
	if hash apt-get 2>/dev/null; then
	  apt-get update -qq >/dev/null && sudo apt-get install -qq python3-pip
	elif hash pacman 2>/dev/null; then
	  pacman -Syu python-pip --noconfirm
	elif hash dnf 2>/dev/null; then
	  dnf install -y python3-pip
	else
	  echo -e "Please install python3-pip"
	fi
	pip3 install --upgrade ansible ansible-lint


update:
	git pull origin master
	git submodule update --init --recursive
	git submodule foreach "(git checkout master; git pull origin master)"
	git config --global submodule.recurse true
