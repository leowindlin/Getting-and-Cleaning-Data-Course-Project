# Getting-and-Cleaning-Data-Course-Project
Here I present a guide on how to run the codes for the Course Project. Please refer to the file **CodeBook.md** for further explanations on how the codes work.

## How to run the codes
1. Download all the **.R** files to your computer.
2. Open **run_analysis.R** and set the variable *path* as the working directory of your choice.
3. Run the whole code **run_analysis.R**. This will save run all the codes and save the answer to Exercise 5 in your working directory as a txt file: **tidydata.txt**.
4. To check the tidydata.txt file, run the following code:
```sh
tidydata<-read.table("tidydata.txt",header=TRUE)
```
