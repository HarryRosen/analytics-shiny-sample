## Harry Rosen Analytics: Shiny Sample  

Welcome to the Harry Rosen Analytics Shiny Pre-Interview sample evaluation repository!  

#### **The purpose of this repository**:   
> Provide an example Shiny project to users that are interested in applying for the Data Products Developer position at Harry Rosen. As the role will **require experience using Shiny, R and Git**, this example project allows the Harry Rosen Analytics team to evaluate potential candidate based on development practices. 

**NOTE:** Complete the entire README to understand the criteria, limitations and what we are looking for in your submissions.  

#### Repository Structure

Below is a dendogram of the file directory accompanied with a folder description:  

```{cmd}
+-- analytics-shiny-sample.Rproj
+-- app.R
+-- data
|   \-- uk-ecommerce.csv
+-- modules
|   \-- select.R
+-- README.md
+-- src
|   +-- 1_load.R
|   \-- 2_clean.R
+-- ui
|   +-- components
|   |   \-- 1_navbar.R
|   +-- tabs
|   |   +-- tab_1.R
|   |   +-- tab_2.R
|   |   \-- tab_3.R
|   \-- ui.R  
```  

`modules` - a subfolder for existing modules. Add new modules to the project here  
`ui` - A subfolder for ui components and tabs. Add new ui to the project here  
`src` - A subfolder for utilities. Add new utility scripts to the project here    
  
  
#### Project Installation  

1. First, clone the repository into your working directory:  

```{cmd}
git clone https://www.github.com/HarryRosen/analytics-shiny-sample.git
```

2. Download and install the dependencies if you haven't already for R:   

```{R}
#Primary shiny library
if(!require("shiny")) install.packages('shiny')

#shiny development framework for mobile applications (framework 7)
if(!require("shinyMobile")) install.packages('shinyMobile')

#Data transformation and aggregation library
if(!require("dplyr")) install.packages('dplyr')

#Apexchart.js library - interactive visualization   
if(!require("apexcharter")) install.packages('apexcharter')

#Read file extensions to open file type 
if(!require("readr")) install.packages('readr')  

#Datatable extensions 
if(!require("DT")) install.packages('DT')  

```

3. Run `app.R` to render the application from R console or RStudio (preferred) 


#### Dataset  

For more information about the underlying dataset, please see: https://www.kaggle.com/carrie1/ecommerce-data  

# Feature Request  

The features are suggested routes for a developer to have tasks around what could be done to improve the app's usability. If you have other features you'd prefer to make, create an issue and see about implementing it into your submission. 

The following is a suggested list of tasks we think the app could use in it's current state:   
*NOTE: It is NOT required to complete all feature requests listed below*

1. Add a feature to the `2_clean.R` script that pertains to geography (`Country`). (ETA: 5 minutes)  

2. Add a visualization of a weekly trend by country with UI that controls the date range and the country selection. (ETA: 30 minutes) Consider: [`timetk`](https://github.com/business-science/timetk)    
3. Include a `datatable()` that has the option to export the country performance into a `.csv` or `.xlsx` file  (ETA: 20 minutes)  

4. Convert a piece of UI into a module in the Shiny code. See the `modules/select.R` code for an example. (ETA: 10 minutes)  

5. Add a tooltip to a visualization or piece of UI to help the user navigate the application. (ETA: 5 minutes)  

BONUS: Complete all features requested above (ETA: 1 hour)  

**EXTRA:** Flex your shiny skills by providing a useful insight for an audience of the executive team to review their e-commerce sales performance. Use your submission to support your claims (ETA: 20 - 60 minutes)  


### What are we looking for  

For the *Data Product Developer* position, we are looking for candidates who can develop in R using `shiny` libraries to create a dashboard when provided data and how work is submitted regularly into github or bitbucket.  For each submission, we are evaluating criteria for each of the following:   

1. Git practices - What does your branch etiquette look like? How are your commit messages structured? How are your issues structured (if applicable)? When do you commit your changes?   
2. R & Shiny - Are you familiar with `dplyr`/`magrittr` pipes? Can you conduct Exploratory Data Analysis (Static or Dynamic within Shiny UI)? Can you turn ambiguous questions into tangible answers within an app?  
3. Development Practices - Do you consider efficiency of approach?  How might some of the existing data cleaning and transformations be made more efficient?   
4. Business Insights - Are you delivering useful insights to the defined executive audience?   


### How to submit   

To send us your submission, complete the following:  

1. checkout your custom branch (e.g. [username]); checkout feature and bug branches from your custom branch [if applicable] (e.g. [username]-[#id])    
2. stage and commit your changes to the corresponding branches  
3. commit to your custom branch outlined in step 1.  
4. create a pull request for the 'dev' branch; include a comment with your UUID, if applicable  

### 






