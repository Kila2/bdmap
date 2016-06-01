#!/bin/bash
x=$1
y=$2
z=$3
w=$4
l=$5
if [[ $z -eq 21 ]]; then
	for (( i = 0; i < $w; i++ )); do
		name1=$(printf "%02d" $(($i + 1)))
		for ((j=0; j<$l; j++)) 
		do 
			name2=$(printf "%02d" $(($j + 1)))
			#echo 18_$name1`echo _`$name2.jpg
			mv $z`echo _`$name1`echo _`$name2.jpg $z`echo _`$(($x + $j))`echo _`$(($y - $i)).jpg
		done
	done
else
for((i=0;i<$w;i++))
do
	for ((j=0; j<$l; j++)) 
	do 
		name=$(printf "%02d" $((($j + 1) + ($w * $i))))
		#echo 18_$name.jpg
		mv $z`echo _`$name.jpg $z`echo _`$(($x + $j))`echo _`$(($y - $i)).jpg
	done
done
fi

