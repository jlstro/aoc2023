sum=0; while IFS= read -r line; do numbers=$(echo "$line" | sed 's/[^0-9]*//g'); first_digit="${numbers:0:1}"; last_digit="${numbers: -1}"; if [[ ${#numbers} -eq 1 ]]; then sum=$((sum + (first_digit * 10) + first_digit)); else sum=$((sum + (first_digit * 10) + last_digit)); fi; done < input.txt; echo $sum

