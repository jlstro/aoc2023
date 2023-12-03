#! /bin/bash
FILE="input.txt"
for i in {1..140}; do echo -n .; done > temp.txt
echo "" >> temp.txt
cat "$FILE" >> temp.txt
for i in {1..140}; do echo -n .; done >> temp.txt
echo "" >> temp.txt
for i in {1..140}; do echo -n .; done >> temp.txt
FILE="temp.txt"
sed -i '' 's/^/../' "$FILE"
sed -i '' 's/$/../' "$FILE"
sum=0
above=""
mid=""
while IFS= read -r line
do
	below="$line"
	for ((i=0; i<${#mid}; i++)); do
		char=${mid:$i:1}
		if [[ $char =~ [0-9] ]]; then
			start=$i
			while [[ $i -lt ${#mid} && ${mid:$i:1} =~ [0-9] ]]; do
				i=$((i+1))
			done
			substring=${mid:$((start-1)):$((i-start+2))}
			number=${mid:$start:$((i-start))}
			next_char=${substring: -1}
			prev_char=${substring:0:1}
			sub_above=${above:$((start-1)):$((i-start+2))}
			sub_below=${below:$((start-1)):$((i-start+2))}
			if [[ "$sub_above" =~ [^.0123456789] || "$sub_below" =~ [^.0123456789] ||"$prev_char" != "." || "$next_char" != "." ]]; then
				sum=$((sum + number))
			fi
		fi
	done
	above="$mid"
	mid="$below"
done < "$FILE"
rm temp.txt
echo $sum
