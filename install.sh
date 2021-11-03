#!/bin/bash

# Try to install on the argument folder.
if [ "$#" == "1" ]; then
  INSTALL_FOLDER=$1/.git/hooks
  echo "Trying to install on $INSTALL_FOLDER"
	if [ -n $INSTALL_FOLDER ] && [ -d $INSTALL_FOLDER ] ; then
    if [ -e "$INSTALL_FOLDER/commit-msg" ] ; then
      echo "You're already using commit-msg hooks, you'll need to install this manually."
      exit 1
    else
      echo "Copying file..."
      sudo cp commit-msg $INSTALL_FOLDER/
      echo "Done! Installed n ${INSTALL_FOLDER}"
      exit 0
    fi
  else
    echo "Sorry, couldn't find $INSTALL_FOLDER"
    exit 1
  fi
fi

# Try to find git-core hooks folder.
if [ -z $(which find) ] ; then
  echo "Please install the find command. You may need to use Git Bash for Windows or your provided package manager."
  exit 1
fi
INSTALL_FOLDER=$(find /usr/share -path "*/git-core/templates/hooks" -type d -print -quit 2>/dev/null)

if [[ ! -z $INSTALL_FOLDER ]] && [ -n $INSTALL_FOLDER ] && [ -d $INSTALL_FOLDER ] ; then
  if [ -e "$INSTALL_FOLDER/commit-msg" ] ; then
    echo "You're already using commit-msg hooks, you'll need to install this manually."
    echo "You can also use this only on specific projects running ./install.sh path/to/a/repo"
    exit 1
  else
    echo "Copying file..."
    sudo cp commit-msg $INSTALL_FOLDER/
    echo "Done! Installed in ${INSTALL_FOLDER}"
    exit 0
  fi
else
  echo "I didn't found the git-core folder, please install it manually."
  exit 1
fi
