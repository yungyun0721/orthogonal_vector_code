# DOI
[![DOI](https://zenodo.org/badge/557688796.svg)](https://zenodo.org/badge/latestdoi/557688796)

# Using orthogonal vector to improve the ensemble space of the EnKF and its effect on data assimilation and forecasting
This repository is the official implementation of the increased-size EnKF system by using the orthogonal vector to improve the EnKF performance under the lorenz 96 model.
![model_illustration](figure/Figure1.jpg)

## Requirements
Software requirement: Matlab 2017a

To install libraries:
1. go to the SPROUT folder
```
sprout.initializer
```
2. back to the main_code folder

## Run experiments

1. This repository offers 3 kinds of experiment: 
- offline experiment
- online  experiment
- online imperfect model experiment

2. the offline experiments
```mermaid
graph LR;
st[offline experiment]-->a1
a1[main_offline_6ens<br>adding one vecoter and control run]
a1-->b1(control run with 6 ensemble members)
a1-->b2(random orthogonal vector)
a1-->b3(IESV1)
a1-->b4(Orthogonal IESV1)
a1-->b5(Ensemble mean vector)
a1-->b6(Orthogonal ensemble mean vector)
st[offline experiment]-->a2
a2[main_offline_8_ens_IESV_ensmean]
a2-->c1(8 member experiment<br>adding ensemble mean vector and IESV1)
```
3. the online experiment
```mermaid
graph LR;
st[online experiment]-->a1
a1[main_online_6ens<br>adding one vecoter and control run]
a1-->b1(control run with 6 ensemble members)
a1-->b2(random orthogonal vector)
a1-->b3(Orthogonal IESV1)
a1-->b4(Orthogonal ensemble mean vector)
st[online experiment]-->a2
a2[main_online_8_ens_IESV_ensmean]
a2-->b5(8 member experiment<br>adding ensemble mean vector and IESV1)
st[online experiment]-->a3
a3[main_7_ens]
a3-->b6(EnKF with 7 ensmeble member)

```

4. the online imperfect model experiment
```mermaid
graph LR;
st[online imperfect model experiment]-->a1
a1[main_online_6ens_imperfect_new<br>adding one vecoter and control run]
a1-->b1(control run with 6 ensemble members)
a1-->b2(Orthogonal IESV1)
a1-->b3(Orthogonal ensemble mean vector)
st[online imperfect model experiment]-->a2
a2[main_online_8_ens_IESV_ensmean_imperfect]
a2-->b4(8 member experiment<br>adding ensemble mean vector and IESV1)
st[online imperfect model experiment]-->a3
a3[main_7_ens_imperfect]
a3-->b5(EnKF with 7 ensmeble member)
```
### after finish the main.m 
`da_run`  : control run
`da2_run` : experiment


# analysis
All analysis needs to be started from the RMSE_count.m or RMSE_count_imperfect.m

### in figure folder
1. figure2: projection_time_local_max.m
2. figure3: projection_time_local_max.m + improvement_time_local_max
3. figure4: cosIESV1_ensmean_leave_F_T.m
4. figure5 and 6 :plot_svd_for_RMSE.m

## the experiment data could be reproduced by the code




