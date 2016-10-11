##Instruction

###Directory hw1 concludes the following items:

- normarlizeFileNames.sh: the script for hw1 exercise1.

- summarizeSNaQres.sh: the script for hw1 exercise3. the first part which I use comments is for hw1 exercise2.

- readme.md: Instruction

- directory hw1-snaqTimeTests: data

- directory result: the final result of exercise2 is stored in combined.csv, and the final result of exercise3 is stored in exercise3.csv

###Script Details

- normarlizeFileNames.sh: mv ${filename} ${filename/timetest/timetest0} to change to filename; loops.

- summarizeSNaQres.sh: I create three independent csv files, and paste them together at last. echo, grep, cut, sed, loop, paste are used.

###Script for Exercise3
- summarizeSNaQres.sh is for exercise3 and is used this time.

- data: 10/11/2016

- summarizeSNaQres.sh is in directory hw1.

- summarizeSNaQres.sh is for provide a csv file with columns analysis, h, CPUtime, Nruns, Nfail, fabs, frel, xabs, xrel, seed, under3460, under3450, under3440
