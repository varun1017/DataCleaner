#!/bin/bash
tag=div class="field-item even"
sed -n '/<div class="field field-name-field-total-confirmed-indians field-type-number-integer field-label-above">/,/<\/div>/p' covid_status.html >> output.txt
awk -F">" '{print $6,$14}' output.txt >> output1.txt
sed -i '/^[[:space:]]*$/d' output1.txt #removing blank lines
sed -i 's/$/ /' output1.txt
sed -i 's/<//g' output1.txt
sed -i 's/div / /g' output1.txt
sed -i 's/div$//g' output1.txt
sed -i 's/[^[:alnum:][:space:]]\+//g' output1.txt
> output.txt
touch s.txt
cp sample.txt s.txt
sed -i -e '$a\' s.txt
while IFS=$'\t\r\n' read -r line; 
do
    sed -n "/^$line/p" output1.txt >> output.txt
done < s.txt
> output1.txt
awk '{print $NF,$0}' output.txt > output1.txt
> output.txt
sort -k 1n output1.txt > output.txt
>output1.txt
cut -f 2- -d ' ' output.txt > output1.txt
> output.txt
cp output1.txt output.txt
rm output1.txt
rm s.txt