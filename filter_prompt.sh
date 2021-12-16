#!/bin/bash
# Filters stdin character by character, only keeping lines starting with the prompt strings 
# =====================================================
# 	PROMPT STRINGS MUST BE MANUALLY ENTERED
# =====================================================
# Regular prompt string:
ps1="joe@joe-Desktop-Ubuntu:"
# continued line prompt string:
ps2=">"



set -euo pipefail 
IFS=''
isPrompt=false


if [ -z ${ps1+x} ] || [ -z ${ps2+x} ]
then
	error "Prompt strings not defined in filter_prompt.sh" 2
fi




function checkLineStart (){
	prefix=""

	# read the first character
	read -N1 ans

	# if the first character is the multiline prompt string, 
	#	then we're still in a prompt.  Print the char and return 
	if [[ $ans == $ps2 ]] && [[ $isPrompt = true ]]
	then
		echo -n $ans
		return
	fi

	isPrompt=true
	failedOnNewline=false
	index=0

	while (( $index < ${#ps1} ))
	do
		# if index is 0 we've already read the character
		if [ $index != 0 ]
		then
			read -N1 ans
		fi
		prefix=${prefix}$ans

		# if the chacracter doesn't match ps1[index], 
		#	we're not in the prompt
		if [[ $ans != ${ps1:index:1} ]]
		then
			isPrompt=false
			if [[ $ans == $'\n' ]]
			then
				failedOnNewline=true
			fi
			return
		fi
		index=$((index+1))
	done

	# got to the end, so prompt matches.  print it
	echo -n $ps1
}


checkLineStart

while [ 1 ]
do
	if [ $failedOnNewline = false ]
	then
		read -N1 ans
	fi

	# echo -n "[$ans]"
	if [[ $ans == $'\n' ]]
	then
 		# print the newline if it finishes a prompt line
 		if [ $isPrompt = true ]
 		then 
			echo -n $ans
		fi

 		checkLineStart
 	else
	 	# if we're on a prompt line, print the character
		if [ $isPrompt = true ]
		then
			echo -n $ans
		fi
	fi
done

