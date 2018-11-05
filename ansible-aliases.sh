#!/bin/bash

set -eu
set -o pipefail

DOCKER_IMAGE='gdiener/ansible'
DOCKER_TAG='latest'
SSH_KEY_ENV=''
PLAYBOOK_ENV=" -v \$(pwd):/playbook/"
EXTRA_ENV=''
REMOVE=false
FILE_NAME=~/.ansible-aliases
FILE_INCLUDE="source ${FILE_NAME}"
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

function error_message {
	echo "[!] ${1}, use '--help' flag for more information"
	exit 1
}

function message {
	echo ">> ${1}"
}

function help_message {
	echo
	echo "Usage: ansible-aliases [OPTIONS]"
	echo
	message "Install dockerized Ansible tools aliases"
	echo
	echo 'Options:'
	echo '   -k, --key string         The path of the SSH key to use'
	echo '   -p, --playbook string    The path of the playbook to use (default $(pwd))'
	echo '   -t, --tag string         The Docker tag to use'
	echo '   -e, --env string         Set environment variables'
	echo '       --remove             Uninstall Ansible aliases'
	exit 2
}

while [[ $# -gt 0 ]];do
	key="${1}"

	case ${key} in
		-h|--help)
			help_message
		;;
		-k|--key)
			if [ -z ${2+x} ]; then
				error_message "Missing ${key} value"
			fi
			SSH_KEY_ENV="-e \"SSH_KEY=\$(cat ${2})\""
			shift
			shift
		;;
		-p|--playbook)
			if [ -z ${2+x} ]; then
				error_message "Missing ${key} value"
			fi
			PLAYBOOK_ENV="-v ${2}:/playbook/"
			shift
			shift
		;;
		-t|--tag)
			if [ -z ${2+x} ]; then
				error_message "Missing ${key} value"
			fi
			DOCKER_TAG=${2}
			shift
			shift
		;;
		-e|--env)
			if [ -z ${2+x} ]; then
				error_message "Missing ${key} value"
			fi
			EXTRA_ENV+=" -e \"${2}\""
			shift
			shift
		;;
		--remove)
			REMOVE=true
			shift
		;;
		*)
			error_message "Unrecognized option ${key}"
    	;;
	esac
done

for _FILE in ${SHELL_CONFIG_FILES[@]}; do
	if [ -w "${_FILE}" ]; then
		if [ "${REMOVE}" = true ]; then
			if grep -q "${FILE_INCLUDE}" ${_FILE}; then
				sed -i.old "s#${FILE_INCLUDE}##" ${_FILE}
				message "Aliases file uninstalled from ${_FILE}"
			fi
		else
			if grep -q "${FILE_INCLUDE}" ${_FILE}; then
				message "Aliases file is already installed in ${_FILE}"
				exit 0
			else
				cp ${_FILE} ${_FILE}.old
				echo '' >> ${_FILE}
				echo ${FILE_INCLUDE} >> ${_FILE}
				message "Aliases file installed in ${_FILE}"
			fi
			break
		fi
	fi
done

if [ "${REMOVE}" = true ]; then
	if [ -w "${FILE_NAME}" ]; then
		rm ${FILE_NAME}
		message "Aliases file removed"
	fi
	exit 0
fi

if [ ! -w "${FILE_NAME}" ]; then
	touch ${FILE_NAME}
else
	> ${FILE_NAME}
fi

for _COMMAND in ${COMMANDS[@]}; do
	echo "alias ${_COMMAND}='docker run ${SSH_KEY_ENV} ${PLAYBOOK_ENV} ${EXTRA_ENV} -it ${DOCKER_IMAGE}:${DOCKER_TAG} ${_COMMAND}'" >> ${FILE_NAME}
	message "Alias ${_COMMAND} installed"
done