# modeling 
This is a program which draw phase space of Sitnikokv problem in R.
The integration was based on this article https://ui.adsabs.harvard.edu/abs/2007AN....328..801K/abstract
 
For a successful launch, you will need:
1. Have R (Rstudio --- for you comfort) on your computer.
2. Install special libraries, if you do not have any:
- library("deSolve") 
- library("ggplot2")
- library("rjson")
  
To install them paste at the Rstudio-console: 
 -     install.packages(c("deSolve", 'ggplot2', "rjson"))

3. Run the program: 
- In terminal:
 -     Rscript sitnikov_problem.r 
 
  - You can run it in Rstudio
 
The list of files names with their description are below.
1.  paramerets.json;
 - It contains input parameters.
 - "z_0": 3.5,  the initial height, it is tha last z_0-value for which the portrais will be drawn.
 - "dz":0.1,  heigth step
 - "e": 0.01,  # ccentricity
 - "n": 400  number of periods
2. sitnikov_problem.r; 
   - It is a main program.
3.  phase_space_e_$e_z_0_$z_0.png;
  -   It is output file with phase space.
  -    $e here means a real value from  paramerets.json. 
  -  For instance the  output file for current paramerets.json is  phase_space_e_0.01_z_0_3.5.png
 



