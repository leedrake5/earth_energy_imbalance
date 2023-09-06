# earth_energy_imbalance
 Calculating Earth's energy imbalance historically using proxies

## Methods
The present repository is an implementation of the methods described in [Shackleton et al. 2023 *Benthic δ18O records Earth’s energy imbalance*](https://www.nature.com/articles/s41561-023-01250-y). 

![Shackleton et al. 2023 methods](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/paper_figures/shackleton_et_al_2023.JPG?)

The replication attempt here is not perfect, but it is useable. This is the method adapted to [the paper's data](https://doi.org/10.5281/zenodo.8237374):
![Present replication attempt](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/calculations_check.jpeg?)

This does not create an exact 1:1, and unit conversions aren't perfect on my end, but the results are useable and consistent with the papers. This can thus be adapted to longer time sequences, such as Huyber's average of the LRO4 data (I prefer this due to reduced dependence on orbital assumptions): 

![Huybers 2006 earth energy imbalance](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/huybers_recent.jpeg?)

Less variation occurs in this record compared to the Lisiecki and Stern 2016 recrod, but the imbalances associated with the Holocene and Eemian interglacial transitions are still of comparable magnitude. This also can be extended considerably father back using the classic Zachos 2001 data with overlaps checked against the more recent records: 

![Zachos 2001 earth energy imbalance](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/zachos_pleist.jpeg?)

...and even further back to the Paleo-Eocene Thermal Maximum (PETM)

![Zachos 2001 earth energy imbalance](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/zachos_petm.jpeg?)

One observable phenomenon is that a) energy imbalances are more extreme the later in the cenozoic we are and b) the PETM doesn't feature higher energy imbalances but instead those which occur tend to be positive, not negative. A cautionary note on the graphs here: This method likely generalizes well to the Pleistocene, but as we go farther back things get considerably more complicated. To me the Zachos data shows too wild of swings in energy balance, though this will require future research. My supiscion is the oddness is related to data density getting higher as we get closer to the present date. I added a smoothing parameter that, when set to 50 (e.g. 25 ka) resolves both high values compared to LR04 and to a lesser extent eveness.

Note that the time derivative changes the scale of the earth's energy imbalance - using a larger time slice in the Zachos benthic records will result in higher values. The function attempts to force every record to comply with Shackleton et al's age sampling, but the user must make sure Ages are in kiloyears before inputting into the function. 

## Citations
Huybers, P., Glacial variability over the last two million years: an extended depth-derived agemodel, continuous obliquity pacing, and the Pleistocene progression. Quaternary Science Reviews, 26(1-2), pp.37-55 (2007). https://doi.org/10.1016/j.quascirev.2006.07.013


Lisiecki, L. E. & Stern, J. V. Regional and global benthic δ18O stacks for the last glacial cycle. Paleoceanography 31, 1368–1394 (2016). https://doi.org/10.1002/2016PA003002

Shackleton, S., Seltzer, A., Baggenstos, D. et al. Benthic δ18O records Earth’s energy imbalance. Nat. Geosci. 16, 797–802 (2023). https://doi.org/10.1038/s41561-023-01250-y

Zachos, J., Pagani, H., Sloan, L., Thomas, E. & Billups, K. Trends, rhythms, and aberrations in global climate 65 Ma to present. Science 292, 686–693 (2001). https://doi.org/10.1126/science.1059412 
