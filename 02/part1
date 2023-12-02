 cat input.txt | sed '/[,:;]\ [2-9][0-9]/d' | sed '/[,:;]\ 1[5-9]/d' | sed '/1[3-9] red/d' | sed '/1[4-9] green/d' | awk 'END { print sum } { sum += $2 }'
