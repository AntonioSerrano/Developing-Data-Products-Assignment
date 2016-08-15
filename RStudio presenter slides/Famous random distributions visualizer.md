<style>
/* Your other css */
.section .reveal .state-background {
    background-image: url(http://www.bigdata.cl/wp-content/uploads/2013/01/cyber_c.jpg);
    background-position: center center;
    background-attachment: fixed;
    background-repeat: no-repeat;
    background-size: 100% 100%;
    }
</style>

Famous random distributions visualizer
========================================================
author: by Antonio Serrano
date: August, 2016
transition: linear
autosize: true
font-family: 'Calibri'
width: 1440
height: 900

Overview
========================================================

This presentation has been created using RStudio Presenter as part of the peer assessment for the Coursera Developing Data Products course, offered by Johns Hopkins University through Coursera.org. The aim of the assignment is to ensure that the students are capable of using:

+ Shiny package to build data product application
+ R-Presentation or Slidify to create data product related presentations

The Shiny app at hand draws random samples from 10 different famous probability distributions and plots the samples using base R functions. It is avalilable at:

<https://antonioserrano.shinyapps.io/Famous_random_distributions_visualizer/>

Source code for ui.R and server.R files are available on the GitHub repo: 

<https://github.com/AntonioSerrano/Developing-Data-Products-Assignment>

Available distributions
========================================================

Specifically, the app includes the following distributions:
* Discrete distributions:
    + Binomial (rbinom funcion embedded in R)
    + Poisson (rpois)
    + Geometric (rgeom)
* Continuous distributions:
    + Uniform (runif)
    + Normal (rnorm)
    + Log-normal (rlnorm)
    + Exponential (rexp)
    + Gamma (rgamma)
    + Chi-square (rchisq)
    + F (rf)

Application layout
========================================================

The app has a slider panel on the left side. There you can select the sample size from 1 to 10,000 observations. Likewise, the parameters to be entered change according to the chosen distribution. You can modify those parameters as desired considering their space limitations.

Each time you chose a distibution, sample size, and specific values for its parameters, R performs its corresponding random generation function. For instance, if you select a normal distribution with a sample size of 10, mean equal to 0 and standard deviation equal to 1, the software does this in the background:


```r
example <- rnorm(n = 10, mean = 0, sd = 1)
example
```

```
 [1] -1.24992538 -0.46036539  0.48643763 -0.24106405 -0.63787090
 [6] -2.41258186  0.06554761  0.29832641 -0.91319748 -1.57986936
```

Application ouputs I
========================================================

On the main panel at the right side you can select the type of output from the random distribution generated. In particular, you can visualize histograms, summary statistics, and raw data generated in table format.


```r
## Plot (histogram)
hist(example,
     breaks = 30)
```

<img src="Famous random distributions visualizer-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

Application ouputs II
========================================================


```r
## Summary statistics
summary(example)
```

```
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-2.41300 -1.16600 -0.54910 -0.66450 -0.01111  0.48640 
```

Finally, both graphics and raw data from the random distributions can be downloaded by pressing the "Download Graphic" and "Download Sample" buttons respectively on the slider panel at the bottom.

![Download graphic button look](downloadGraphic.png)
![Download sample button look](downloadSample.png)
