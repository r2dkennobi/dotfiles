#!/bin/bash

# References used
# - http://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

# VARIABLES
SCRIPT=${BASH_SOURCE:-$0}
SCRIPT_DIR="$( readlink -f $(dirname "$SOURCE") )"
CUR_DIR="$( pwd )"
[[ -x $(command -v pip) ]] && NO_PIP=false || NO_PIP=true
[[ -x $(command -v ansible-playbook) ]] && NO_ANSIBLE=false || NO_ANSIBLE=true
[[ -x $(command -v apt-get) ]] && IS_UBUNTU=true || IS_UBUNTU=false
[[ -x $(command -v pacman) ]] && IS_ARCH=true || IS_ARCH=false

# Parse command line arguments
# first ":" used to disable default error handling
while getopts ":hi:" opt; do
    case ${opt} in
        h) # Print usage
            echo "Usage: ${SCRIPT} [-h]"
            ;;
        i)
            target=$OPTARG
            ;;
        \?) # Print usage due to invalid option
            echo "Invalid Option: -$OPTARG" 1>&2
            exit 1
            ;;
        :)
            echo "Invalid Option: -$OPTARG requires an argument" 1>&2
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))    # shift processed option

echo "SCRIPT_DIR $SCRIPT_DIR"
echo "UBUNTU $IS_UBUNTU"
echo "ARCH $IS_ARCH"

# Make sure setup dependencies exist
if [[ $NO_PIP ]]; then
    echo "Missing pip. Setting it up..."
    if [[ $IS_UBUNTU ]]; then
        sudo apt-get install -y python-pip
    elif [[ $IS_ARCH ]]; then
        sudo pacman -S install python-pip --noconfirm
    fi
fi

if [[ $NO_ANSIBLE ]]; then
    echo "Missing ansible. Setting it up..."
    sudo pip install -y ansible
fi

if [[ $target == "all" ]]; then
    echo "Installing all apps"
    if [[ $IS_UBUNTU ]]; then
        TARGET_YAML=$SCRIPT_DIR/ansible/all_ubuntu.yaml
    elif [[ $IS_ARCH ]]; then
        TARGET_YAML=$SCRIPT_DIR/ansible/all_arch.yaml
    fi
    ansible-playbook -i $SCRIPT_DIR/ansible/localhost $TARGET_YAML --ask-sudo-pass
else
    echo "Unknown argument: ${target}"
    exit 1
fi
