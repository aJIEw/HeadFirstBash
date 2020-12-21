#!/bin/bash

clear

# if else statement
i="Five"
#i='One'
if [ ${#i} -eq 4 ]; then # CAVEAT: the [ and ] outside of a condition must have a blank space to seperate them!
	echo Hi${i}!
elif [ $i == "One" ]; then 
	echo You are No.1!
else
	echo Nice to meet you $i
fi

# case statement
i=`ls -l | wc -l`
echo $i
case $i  in
	[0] )
		echo "there's no file"
		;;
	[1] )
		echo "there's only one file"
		;;
	[2-4] )
		echo "there're some files"
		;;
	* )
		echo "there're a lot of files"
		;;	
esac


# show some expression examples
function expression {
	statement1 && statement2   # both statements are true
	statement1 || statement2   # at least one of the statements is true

	expression1 && expression2 # if expression1 executed with no error, then execute expression2
	expression1 && expression2 # if expression1 executed with error, then execute expression2
	
	str1 = str2     # str1 matches str2
	str1 != str2    # str1 does not match str2
	str1 < str2     # str1 is less than str2
	str1 > str2     # str1 is greater than str2
	-n str1         # str1 is not null (has length greater than 0)
	-z str1         # str1 is null (has length 0)
	
	-a file         # file exists
	-d file         # file exists and is a directory
	-e file         # file exists; same -a
	-f file         # file exists and is a regular file (i.e., not a directory or other special type of file)
	-r file         # you have read permission
	-s file         # file exists and is not empty
	-w file         # you have write permission
	-x file         # you have execute permission on file, or directory search permission if it is a directory
	-N file         # file was modified since it was last read
	-O file         # you own file
	-G file         # file's group ID matches yours (or one of yours, if you are in multiple groups)
	
	file1 -nt file2     # file1 is newer than file2
	file1 -ot file2     # file1 is older than file2
	
	-lt     # less than
	-le     # less than or equal
	-eq     # equal
	-ge     # greater than or equal
	-gt     # greater than
	-ne     # not equal
}

