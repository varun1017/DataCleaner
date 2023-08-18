#!/bin/bash  

touch output.txt
  
value1=`cat sample.txt`  
value2=`cat stopwords.txt`
value3=`cat suffixes.txt`

sed 's/[A-Z]/\L&/g' sample.txt > output.txt  #converting to lower case

sed -i 's/http:[^[:space:]]*/ /g' output.txt  #removing URLs
sed -i 's/https:[^[:space:]]*/ /g' output.txt
sed -i 's/www.[^[:space:]]*/ /g' output.txt

sed -i 's/[ ]\+/ /g' output.txt   #removing extra spaces

sed -i "s/[^a-z[:space:]]//g" output.txt  #removing everything other than letters

sed -i 's/[ ]\+/ /g' output.txt   #removing extra spaces

for var in $value2;  #removing stopwords
     do
     sed -i "s/\<${var}\>//g" output.txt
     done

sed -i 's/[ ]\+/ /g' output.txt   #removing extra spaces     

sed -i "s/^[ \t]*//" output.txt    #removing leading blank spaces in every line

sed -i '/^[[:space:]]*$/d' output.txt #removing blank lines

sed -i 's/\b\(\w\)\{1,2\}\b\s*//g' output.txt #removing words having less than 2 letters

sed -i 's/[ ]\+/ /g' output.txt   #removing extra spaces

for suffix in $value3;  #identifing words with given suffixes
     do
     sed -i "s/${suffix}[[:space:]]/7 /g" output.txt
     sed -i "s/${suffix}$/7/g" output.txt
     done    

sed -i "s/7//g" output.txt  #removing the suffixes

sed -i 's/[ ]\+/ /g' output.txt   #removing extra spaces