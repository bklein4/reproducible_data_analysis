---
title: "Final Project"
author: "Barbara Klein"
date: "11/22/2020"
output: html_document
---

```{r setup, include=FALSE}
library(tidyverse)

grinches_full <- read.csv(file = "C:/Users/User/Desktop/grinches/grinches.csv", 
                          header = TRUE, 
                          na.strings = c(""," ", "ND", "NA")
                          ) 
```
Retrieve the data set from the location on your computer. In this case, it's called grinches.csv, and we will rename in R as 'grinches_full' alluding to the fully unaltered file. Here we say header = TRUE where the first row are names of the proceeding columns.
'na.strings' allows us to go through the .csv file and remove any empty cells(""), cells with one space in them (" "), or cells with "ND" (for NO DATA").

```{r}
grinches_tibble <- as_tibble(grinches_full) #set grinches_full dataset as a tibble
grinches_tibble #this command shows the tibble
```

As we’re looking at the tibble, there are undesirable names, so we will rename them with the dplyr::rename() function which comes with tidyverse. We also don't need columns "SampleID", "BarcodeSequence", "Depth", "Sample.Name.", "LinkerPrimer", "Description", "Tube.number", "Preserved.For", "X", or "X.1" since we don't need repeat data, or data pertaining to DNA extractions. These will be 'dropped' with the dplyr::select(-c()) function.

```{r}
colnames(grinches_tibble) #shows original column names
grinches_tibble2 <- grinches_tibble %>%
  dplyr::select(-c(
      "ï...SampleID",
      "Station", 
      "Julian.Date",
      "BarcodeSequence", 
      "Depth", 
      "Sample.Name.",
      "LinkerPrimer", 
      "Description", 
      "Tube.number",
      "Preserved.For", 
      "X", 
      "X.1", 
   )) %>%  
dplyr::rename(c(
    x = LATITUDE..S., 
    y = LONGITUDE, 
    dir_cts = DIRECT.COUNTS,
    chl_a = Chl.a,
    leucine = DPM..leucine.,
    bac_prod = Bacterial.Prod.,
    depth_m = Depth..m., 
    mean_no3_no2 = Mean..NO3.NO2.,
    mean_no2 = Mean..NO2.,
    mean_no3 = Mean..NO3.,
    mean_dsi = Mean..DSI.,
    mean_po4 = Mean..PO4.ÂµM.,
    ctd_depth = CTD.DEPTH, 
    sig_t = sigma.t, 
    mean_nh4 = Mean..NH4.ÂµM.,
    sal_psu = Salinity.psu,
    degrees_c = TÂ.C,
  )) 
```
We have a desired tibble with removed columns we don't need, as well as correctly named columns for a spatial data frame (used for our kriging method). 

```{r}
as.data.frame(grinches_tibble2) #We see the data frame in the correct format, but row 41 has no useful information other than "control" for every column. So we will get rid of row 41. 
grinches_tibble2 <- grinches_tibble2[-c(41),]
grinches_tibble2 #here it prints 40 rows instead of 41
 
```
```{r}
str(grinches_tibble2) #shows the columns are 'chr' elements. We need them to be numerics. 
sapply(grinches_tibble2, class) #shows again, all variable return as characters. 
grinches_tibble2$depth_m <- as.numeric(as.character(grinches_tibble2$depth_m))
str(grinches_tibble2) #now it shows depth_m as a numeric instead of a character. So we'll go ahead and use this command for our desired columns to be used in the spatial data frame. 

```

```{r}
grinches_tibble2$x <- as.numeric(as.character(grinches_tibble2$x))
grinches_tibble2$y <- as.numeric(as.character(grinches_tibble2$y))
grinches_tibble2$dir_cts <- as.numeric(as.character(grinches_tibble2$dir_cts))
grinches_tibble2$chl_a <- as.numeric(as.character(grinches_tibble2$chl_a))
grinches_tibble2$leucine <- as.numeric(as.character(grinches_tibble2$leucine))
grinches_tibble2$bac_prod <- as.numeric(as.character(grinches_tibble2$bac_prod))
grinches_tibble2$mean_no3_no2 <- as.numeric(as.character(grinches_tibble2$mean_no3_no2))
grinches_tibble2$mean_no2 <- as.numeric(as.character(grinches_tibble2$mean_no2))
grinches_tibble2$mean_no3 <- as.numeric(as.character(grinches_tibble2$mean_no3))
grinches_tibble2$mean_dsi <- as.numeric(as.character(grinches_tibble2$mean_dsi))
grinches_tibble2$mean_po4 <- as.numeric(as.character(grinches_tibble2$mean_po4))
grinches_tibble2$mean_nh4 <- as.numeric(as.character(grinches_tibble2$mean_nh4))
grinches_tibble2$ctd_depth <- as.numeric(as.character(grinches_tibble2$ctd_depth))
grinches_tibble2$sig_t <- as.numeric(as.character(grinches_tibble2$sig_t))
grinches_tibble2$sal_psu <- as.numeric(as.character(grinches_tibble2$sal_psu))
grinches_tibble2$degrees_c <- as.numeric(as.character(grinches_tibble2$degrees_c))

#all specified columns have now been converted from character vectors to numeric vectors.
```

Now we want the depth to read negative.

```{r}
grinches_tibble2$depth_m <- grinches_tibble2$depth_m * -1
grinches_tibble2 #all values now appear to be in the appropriate format.
```
```{r}
grinches_df <- as.data.frame(grinches_tibble2)
class(grinches_df) #returns "data.frame" (which is what we want)
```

Now we'll convert the grinches_df into a spatial data frame. First we'll download the necessary packages, and then specify which columns contain our unique coordinates. 

```{r}
library(sp)
library(gstat)

coordinates(grinches_df) <- ~ x + y
class(grinches_df)
```
```{r}
str(grinches_df) #now we can view the spatial points data frame
```
The '@' symbol on the left hand side indicates five 'slots' where our data/attributes are being held. 
The five slots are: data (at the top), coords.nrs, coords, bbox, and proj4string. 
"@ data" are where our variables associated with the different coordinates are stored. 
"coords" is the matrix of all those coordinate locations. 
"coords.nrs" has the column numbers of the coordinates in the dataframe.
"bbox" are annotating the box in which our coordinates are held: The 'area' we're working within.
"proj4string" annotates the projection information for the coordinates. 

```{r}
bbox(grinches_df) #accesses the bbox slot of the spdf
```
```{r}
coordinates(grinches_df) %>% 
  glimpse
#gives a glimpse of the coordinates. This can be done using the @ function as well
grinches_df@data %>% glimpse
```

## Kriging!
First things first, we need a variogram model so we can interpolate the data. But the variogram can't work with NA's, so we'll get rid of them. 

```{r}
grinches_df@data = na.omit(grinches_df@data) #NA's have now been omitted from the data frame
grinches_df@data %>% glimpse
```


```{r}

```
