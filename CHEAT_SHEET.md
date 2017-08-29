# Terminal Cheat Sheet

Cheet sheet for n00bs. Everything below should be run on a single line (if it looks like something is two lines, it's only because of word wrapping)

| Command | Info |
|---------|------|
| `ls` | List current directory contents |
| `cd` | Change directory. With no arguments, goes to your home directory |
| `cd ..` | Goes to the parent directory ("up one") |
| `cd poop` | Goes to a directory called "poop" from the current directory |
| `mkdir pooping` | Creates a directory called "pooping" in the current directory |
| `mv foo bar` | Renames a file from "foo" to "bar". If a directory called "bar" exists, then it'll move the file "foo" into the directory "bar". |
| `open .` | Open the current directory in Finder |
| `touch poop.txt` | Creates a new empty file called "poop.txt" |
| `open -a TextEdit poop.txt` | Opens the file "poop.txt" in TextEdit* |
| `pwd` | Prints the path of the current directory |
| `cat poop.txt` | Prints the contents of the file called "poop.txt" |
| `echo "Hello world"` | Prints the string "Hello world" to the console |
| `echo "Hello world" \| pbcopy` | Pipes the string "Hello world" to your clipboard |
| `echo "Hello world" > poop.txt` | Writes the string "Hello world" to a new file called "poop.txt" |
| `chmod u+x poop.sh` | Gives users (you) permission to execute `poop.sh` (i.e. run it as code from the command line.)
| `./poop.sh` | Runs `poop.sh` as shell script code. You can test this out by opening `poop.sh` in TextEdit and putting some commands in there like `ls`, then running `./poop.sh` |


* When using TextEdit, remember to make sure files are in plain mode! (Format > Make Plain Text)