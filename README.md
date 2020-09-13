# BullseyeDataset

The Bullseye Shooting dataset is a dataset my uncle has been collecting for some years of his bullseye shooting performance. It contains the date, the modality (competition or practice), the gun used (as well as its caliber) and the punctuation (overall and disaggregated). Each entry represents each time he's done bullseye shooting, where he shoots 6 series of 10 shots each (for a total of 60 shots). Each shot he gets a punctuation from 1 to 10 where 10 is a perfect shot. 

After he and I talked for a while we came with the idea of doing a visualization of the dataset that ressembled a bullseye. To implement it, a circular plot is needed such that the closer to the center means the higher punctuation (with a maximum of 600). In the theta axis I put the date such that you can see the evolution through time and color distinguishes between practice and competition (needless to say practice gets much better punctuation). 

In terms of actually visualizing the data regular scatterplots would probably do the job, but making Bullseye plots for the Bullseye Shooting dataset definetely looks cooler and it is way more impressive for when he shows it to his teammates.

Finally, I decided to build a very simple shiny app such that you can choose what modality to display, as well as to show a brief summary of what guns were used, how many times, and what performance they obtained. It is available at https://jaltes98.shinyapps.io/BullseyePlot/.
