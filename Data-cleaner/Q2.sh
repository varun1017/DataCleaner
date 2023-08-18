#!/bin/bash  
cp sample.txt output.txt #creates output.txt and copies sample.txt into it
i=0; #intialising i to 0
for word in `cat sample.txt` #going through all words in sample.txt
do
    if [[ ! " ${array[*]} " =~ "$word" ]] #storing in an array only if the word didnot appear earlier
    then
        array[$i]=$word;
        i=$(($i+1));
    fi
done
for word in `cat sample.txt` #going through all words in sample.txt
do
    for k in "${!array[@]}" #getting index of all words in the array
    do
        if [[ "${array[$k]}" = "${word}" ]] #checking if the word in sample.txt matches with the word in array
        then
            awk -F: -v value=${word} -v token=${k} '{gsub(value,token)}1'  output.txt > output1.txt && mv output1.txt output.txt #if matches replacing the word in sample.txt by it's index with the help of dummy file output1.txt
        fi
    done
done
