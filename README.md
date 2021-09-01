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
+-- modules
+-- README.md
+-- src
\-- ui
    +-- components
    |   \-- 1_navbar.R
    +-- tabs
    |   +-- tab_1.R
    |   +-- tab_2.R
    |   \-- tab_3.R
    \-- ui.R
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
if(!require("shiny")) install.packages('shiny')
if(!require("shinyMobile")) install.packages('shinyMobile')
```

3. Run `app.R` to render the application from R console or RStudio (preferred) 


# WORK IN PROGRESS
