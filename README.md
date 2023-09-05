# earth_energy_imbalance
 Calculating Earth's energy imbalance historically using proxies

## Methods
The present repository is an implementation of the methods described in [Shackleton et al. 2023 *Benthic δ18O records Earth’s energy imbalance*](https://www.nature.com/articles/s41561-023-01250-y). 

![Shackleton et al. 2023 methods](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/paper_figures/shackleton_et_al_2023.JPG?)

The replication attempt here is not perfect, but it is useable. This is the method adapted to [the paper's data](https://doi.org/10.5281/zenodo.8237374):
![Present replication attempt](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/calculations_check.jpeg?)

This does not create an exact 1:1, and unit conversions aren't perfect on my end, but the results are useable and consistent with the papers. This can thus be adapted to longer time sequences, such as Huyber's 2006 average of the LRO4 data (I prefer this due to reduced dependence on orbital dating): 

![Huybers 2006 earth energy imbalance](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/huybers_mis05.jpeg?)

This also can be extended considerably father back using the classic Zachos 2001 data: 

![Zachos 2001 earth energy imbalance](https://raw.githubusercontent.com/leedrake5/earth_energy_imbalance/master/outputs/zachos_petm.jpeg?)

Note that the time derivative changes the scale of the earth's energy imbalance - using a larger time slice in the Zachos benthic records will result in higher values. 

