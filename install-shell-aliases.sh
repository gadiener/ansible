#!/bin/bash

set -eu
set -o pipefail

DOCKER_IMAGE='gdiener/ansible'
DOCKER_TAG='latest'
SSH_KEY_ENV=''
PLAYBOOK_ENV=" -v \$(pwd):/playbook/"
REMOVE=false
FILE_NAME=~/.ansible-aliases
FILE_INCLUDE="source $FILE_NAME"
COMMANDS=(
	'ansible'
	'ansible-playbook'
	'ansible-vault'
	'ansible-galaxy'
	'ansible-console'
	'ansible-config'
	'ansible-doc'
	'ansible-inventory'
	'ansible-pull'
)
SHELL_CONFIG_FILES=(
	~/.kshrc
	~/.bashrc
	~/.zshrc
	~/.bash_profile
)

while [[ $# -gt 0 ]];do
	key="$1"

	case $key in
		-h|--help)
			echo "TODO HELP"
			exit 2
		;;
		-k|--key)
			SSH_KEY_ENV=" -e \"SSH_KEY=\$(cat $2)\""
			shift
			shift
		;;
		-p|--playbook)
			PLAYBOOK_ENV=" -v $2:/playbook/"
			shift
			shift
		;;
		-t|--tag)
			REMOVE=true
			shift
			shift
		;;
		--remove)
			REMOVE=true
			shift
		;;
		*)
			echo "Unrecognized option $key"
			exit 1
    	;;
	esac
done

for _FILE in ${SHELL_CONFIG_FILES[@]}; do
	if [ -w "$_FILE" ]; then
		if [ "$REMOVE" = true ]; then
			if grep -q "$FILE_INCLUDE" $_FILE; then
				sed -i.old "#$FILE_INCLUDE#d" $_FILE
				echo "Aliases file uninstalled from $_FILE"
			fi
		else
			if grep -q "$FILE_INCLUDE" $_FILE; then
				echo "Aliases file is already installed in $_FILE"
			else
				cp $_FILE $_FILE.old
				echo $FILE_INCLUDE >> $_FILE
				echo "Aliases file installed in $_FILE"
			fi
			break
		fi
	fi
done

if [ "$REMOVE" = true ]; then
	if [ -w "$FILE_NAME" ]; then
		rm $FILE_NAME
		echo "Aliases file removed"
	fi
	exit 0
fi

if [ ! -w "$FILE_NAME" ]; then
	touch $FILE_NAME
else
	> $FILE_NAME
fi

for _COMMAND in ${COMMANDS[@]}; do
	echo "alias ${_COMMAND}='docker run${SSH_KEY_ENV}${PLAYBOOK_ENV} -it ${DOCKER_IMAGE}:${DOCKER_TAG} ${_COMMAND}'" >> $FILE_NAME
	echo "Alias ${_COMMAND} installed"
done

exit 0