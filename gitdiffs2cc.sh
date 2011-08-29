#!/bin/sh -e

if [ $# -eq 0 ]
then
	echo "Usage: `basename $0` [# of commits] \"[Review title]\""
	exit 65
fi

# Example commit line:
# d5e8109 Fixed tests from previous commit
count=`expr $1`
message=$2
author=`git config --get user.name`

echo "Creating code review: $message"
gitout=`git log -$count --pretty=format:'%h %s' --author="$author" --no-merges`
echo "$gitout" | while read line; do echo "  $line"; done
echo "Are you ready to boogie? (y/n)"
read -n 1 boogie

if [ "$boogie" != "y" ]; then
	echo "\nWell then figure it out."
	exit
fi

/Applications/ccollab_client/ccollab admin review create --title "\"$message\""

echo "$gitout" | while read line; do
	rev=${line:0:7}
	msg=${line:8}
	echo "Commit: $rev Msg: $msg"
	/Applications/ccollab_client/ccollab addgitdiffs --upload-comment "\"$msg\"" last $rev^ $rev
done

