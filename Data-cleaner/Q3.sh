#!/bin/bash  

touch spam.txt
touch ham.txt
touch hbuffer.txt
touch sbuffer.txt

value1=`cat sample.txt`

sed -i 's/-/ /g'  word_token_mapping.txt #removing '-'


sed -n '/^0/p' sample.txt > ham.txt #getting ham ones
sed -n '/^1/p' sample.txt > spam.txt #gettibg spam ones

sed -i 's/0//'  ham.txt #fixing them with just tokens
sed -i 's/://'  ham.txt
sed -i 's/|/ /g' ham.txt
sed -i 's/1//'  spam.txt
sed -i 's/://'  spam.txt
sed -i 's/|/ /g' spam.txt

sed -i "s/ /\n/g" spam.txt #keeping only one token in a line 
sed -i "s/ /\n/g" ham.txt

grep -o '[[:alnum:]]*' ham.txt | sort | uniq -c | sed -E 's/[[:space:]]*([0-9]+) (.+)/\2 \1/'  > ham.txt #caluclating frequency of each number
grep -o '[[:alnum:]]*' spam.txt | sort | uniq -c | sed -E 's/[[:space:]]*([0-9]+) (.+)/\2 \1/'  > spam.txt

awk '     
    FNR == NR {
      # reading file1
      values[$1] = "\"" $2 "\""
      next
    }
    {
      # reading file2
      for (elem in values)
        if ($2 == elem)
            values[elem] = values[elem] " \"" $1 "\""
    }
    END {
      for (elem in values)
        print   " "values[elem]" "
    }
'  ham.txt word_token_mapping.txt  >> hbuffer.txt  #mapping with tokens

awk '     
    FNR == NR {
      # reading file1
      values[$1] = "\"" $2 "\""
      next
    }
    {
      # reading file2
      for (elem in values)
        if ($2 == elem)
            values[elem] = values[elem] " \"" $1 "\""
    }
    END {
      for (elem in values)
        print   " "values[elem]" "
    }
'  spam.txt word_token_mapping.txt  >> sbuffer.txt

sed -i 's/ /-/g'  word_token_mapping.txt #restoring tokens file

sed -i 's/"//g' hbuffer.txt  #removing "
sed -i 's/"//g' sbuffer.txt

sed -i "s/^[ \t]*//" hbuffer.txt #removing leading blanks
sed -i "s/^[ \t]*//" sbuffer.txt

sort -k 1nr hbuffer.txt > ham.txt  #sorting 
sort -k 1nr sbuffer.txt > spam.txt

awk '{print $2}' ham.txt > hbuffer.txt  #removing tokens
awk '{print $2}' spam.txt > sbuffer.txt

head -n $1 hbuffer.txt > ham.txt  #keeping specific number of lines
head -n $1 sbuffer.txt > spam.txt

rm sbuffer.txt  #removing temporary files
rm hbuffer.txt