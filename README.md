# Actigraphy Analysis
scripts used for analysis of circadian sleep-activity cycles

### Phillips Respironics Actiware 6.0 with Actiwatch 2.0
Additional information about the actigraphy watches we use in this study is available in the pdf file actiwatchsoftware.pdf.

### 1) actigraphy_analysis.py
After exporting data from Actiware as csv, this script removes NaN values at the beginning and end of the period, since this is when the watch was being fitted to or retrieved from the participant. It also will interpolate up to 5 minutes of missing activity values. 

### 2) circadian_measures/CAR_measures.Rmd
Uses custom script to fit each participant's actigraphy data to an extended cosinor model and compute circadian measures that describe sleep-activity cycles, such as mesor (mean activity level), acrophase (time of peak activity), beta (rate of transition from low to high activity), etc. (Sherman et al, 2015).

This also uses the nparACT package (Blume et al, 2016) to compute circadian measures such as interdaily stability, intradaily variability, relative amplitude, M5 (mean activity level for 5 consecutive hours of greatest activity), and L10 (mean activity level for 10 consecutive hours with lowest activity). 

Further descriptions of circadian measures can be found in the Word file Circadian_Measures_Description.docx.

### 3) group level analyses 
Various scripts examining age group differences with respect to circadian measures and their relationship to associative memory performance, neuropsch test scores, and functional connectivity network metrics (computed using [PyNets](https://github.com/dPys/PyNets)) are provided. 


## References

Blume, C., Santhi, N., & Schabus, M. (2016). ‘nparACT’package for R: A free software tool for the non-parametric analysis of actigraphy data. MethodsX, 3, 430-435.

Sherman, S. M., Mumford, J. A., & Schnyer, D. M. (2015). Hippocampal activity mediates the relationship between circadian activity rhythms and memory in older adults. Neuropsychologia, 75, 617-625.
