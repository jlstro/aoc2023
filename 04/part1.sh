#! /bin/bash
INPUT="input.txt"
TEMP="temp.txt"
cat "$INPUT" | sed -E 's/^Card [0-9]+: //g' | sed 's/ \([0-9]\) / 0\1 /g' | sed 's/ \([0-9]\)$/ 0\1 /g' > "$TEMP"
sum=0
while IFS=' ' read -r -a array
do
	overlap=()
	for ((i=0; i<${#array[@]}; i++)); do
		if [[ "${array[i]}" == "|" ]]; then
			split_index=$i
			break
		fi
	done
	winners=("${array[@]:0:$split_index}")
	scratched=("${array[@]:$split_index}")
	res=0
	for number in ${winners[@]}; do
		if [[ ${scratched[@]} =~ $number ]]; then
			if [[ $res == 0 ]]; then
				res=1
			else
				res=$((res << 1))
			fi
		fi
	done
	sum=$((sum + res))
done < "$TEMP"
rm temp.txt
echo $sum
