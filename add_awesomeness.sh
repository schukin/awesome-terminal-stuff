#!/bin/sh -e

BASH_PROFILE_ADDED=$(grep -n -q "awesome-terminal-stuff/.bash_profile" ~/.bash_profile)

echo "\nAdding the line \"source `pwd`/.bash_profile\" to ~/.bash_profile..."

if [ -n $BASH_PROFILE_ADDED ]; then
	echo "Looks like your .bash_profile already includes this!"
	echo $BASH_PROFILE_ADDED
else
	echo "\n\n# Import awesome-terminal-stuff\nsource `pwd`/.bash_profile" >> ~/.bash_profile
	echo "Done!"
fi

echo "Creating .vimrc symlink..."
ln -s .vimrc ~/.vimrc
echo "Donezo!"
