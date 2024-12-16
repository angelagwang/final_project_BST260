# final_project_BST260

Reproducing All Results:

In order to reproduce the results in this analysis, you should first run the wrangling script in the code folder. This script will load the dataset used in the analysis, perform all the necessary data cleaning, and save the cleaned data files used in this analysis to the data folder.

Once this script is run, you can just run the final-report.qmd and supplementary-methods.qmd files to reproduce the final report and all the supplementary graphs and tables.


Further Information on the Files Saved in the Data Folder: 

The weekly counts data is used in both the final report and supplementary methods. This cleaned dataset contains data from 1985 to 2022 on weekly deaths and population sizes for males and females using the age brackets delineated in the original dataset.

The dat data is used in both the final report and supplementary methods. This is the final cleaned dataset used for most of this analysis. It contains data from 2000 to 2018 on weekly deaths, population sizes, mortality rates, and dates for males and females using the new age brackets that I set.

The dat_excess_original data is used only in the supplementary methods. This cleaned dataset is the same as the dat data but also includes columns with expected mortality rates and excess deaths estimates calculated by the linear model created on all periods from 2000 to 2016.

