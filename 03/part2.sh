#! /bin/bash
FILE="input.txt"
for i in {1..140}; do echo -n .; done > temp.txt
echo "" >> temp.txt
cat "$FILE" >> temp.txt
for i in {1..140}; do echo -n .; done >> temp.txt
echo "" >> temp.txt
for i in {1..140}; do echo -n .; done >> temp.txt
FILE="temp.txt"
sed -i '' 's/^/../; s/$/../' "$FILE"
sum=0
above=""
mid=""
while IFS= read -r line
do
	below="$line"
	for ((i=0; i<${#mid}; i++)); do
		char=${mid:$i:1}
		if [[ $char == '*' ]]; then
			numbers=()
			star=${mid:(($i-1)):3}
			sub_above=${above:(($i-1)):3}
			sub_below=${below:(($i-1)):3}
			if [[ ${star:2:1} =~ [0-9] && ${star:0:1} =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${mid:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${mid:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				res=$(( ${mid:$j:$((i-j+k))} ))
				sum=$((sum + res))
			elif [[ ${above:(($i)):1} =~ [^0-9] && ${above:(($i-1)):1} =~ [0-9] && ${above:(($i+1)):1} =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${above:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${above:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n=$( echo "${above:$j:$((i-j+k))}" | sed 's/[^0-9]/\ * /g' )
				res=$(( $n ))
				sum=$((sum + res))
			elif [[ ${below:(($i)):1} =~ [^0-9] && ${below:(($i-1)):1} =~ [0-9] && ${below:(($i+1)):1} =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${below:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${below:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n=$( echo "${below:$j:$((i-j+k))}" | sed 's/[^0-9]/\ * /g' )
				res=$(( $n ))
				sum=$((sum + res))
			elif [[ $star =~ [0-9] && $sub_below =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${below:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${below:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n1=$(echo "${below:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				j=$i
				k=1
				while [[ ${mid:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${mid:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n2=$(echo "${mid:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				res=$((n1 * n2))
				sum=$((sum + res ))
			elif [[ $star =~ [0-9] && $sub_above =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${above:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${above:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n1=$(echo "${above:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				j=$i
				k=1
				while [[ ${mid:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${mid:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n2=$(echo "${mid:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				res=$((n1 * n2))
				sum=$((sum + res ))
			elif [[ $sub_below =~ [0-9] && $sub_above =~ [0-9] ]]; then
				j=$i
				k=1
				while [[ ${above:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${above:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n1=$(echo "${above:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				j=$i
				k=1
				while [[ ${below:$j-1:1} =~ [0-9] ]]; do
					j=$((j-1))
				done
				while [[ ${below:$((i+k)):1} =~ [0-9] ]]; do
					k=$((k+1))
				done
				n2=$(echo "${below:$j:$((i-j+k))}" | sed 's/[^0-9]*//g')
				res=$((n1 * n2))
				sum=$((sum + res ))
			fi
		fi
	done
	above="$mid"
	mid="$below"
done < "$FILE"
rm temp.txt
echo $sum
