sum=0; while IFS= read -r line; do line=$(echo "$line" | sed 's/nine/n9e/g' | sed 's/eight/e8t/g' | sed 's/seven/7n/g' | sed 's/six/6/g' | sed 's/five/5e/g' | sed 's/four/4/g' | sed 's/three/t3e/g' | sed 's/two/t2o/g' | sed 's/one/o1e/g' | sed 's/zero/0o/g'); numbers=$(echo "$line" | sed 's/[^0-9]*//g'); first_digit="${numbers:0:1}"; last_digit="${numbers: -1}"; if [[ ${#numbers} -eq 1 ]]; then sum=$((sum + (first_digit * 10) + first_digit)); else sum=$((sum + (first_digit * 10) + last_digit)); fi; done < input.txt; echo $sum
