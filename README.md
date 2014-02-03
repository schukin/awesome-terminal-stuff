Awesome Terminal Stuff
======================

Here's some stuff I use.

## vim

	$ ln -s .vimrc ~/.vimrc

## .bash_profile 

	$ echo "source `pwd`/.bash_profile" >> ~/.bash_profile

## Other stuff

At this point this acts as more of a TODO list for me when setting up new dev environments; I'm too lazy to write a script to just set it up all automatically cause I'm not in IT and don't spin up a new Mac every other day.

* [Sublime Text](http://www.sublimetext.com/docs/2/osx_command_line.html):
	```
	$ mkdir ~/bin
	$ ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
	```

* [Homebrew](http://brew.sh)
* [rbenv](https://github.com/sstephenson/rbenv#homebrew-on-mac-os-x)
	```
	$ brew update
	$ brew install rbenv ruby-build
	```

* Ruby
	```
	# list all available versions
	$ rbenv install -l
	$ rbenv install 2.1.0
	```

