##Instruction

###directory hw1 concludes the following items:

- normarlizeFileNames.sh: the script for hw1 exercise1.

- summarizeSNaQres.sh: the script for hw1 exercise2.

- readme.md: Instruction

- directory hw1-snaqTimeTests: data

- directory result: the final result stored in combined.csv

###Script Details

- normarlizeFileNames.sh: mv ${filename} ${filename/timetest/timetest0} to change to filename; loops.

- summarizeSNaQres.sh: I create three independent csv files for each column, and paste them together at last. grep, echo, %.for deleting parts of the sentence, paste -d.
