# SPROUT Data Assimilation Experiment Framework

    SPROUT version : 0.7.b2-b3
    Readme version : 0.7.b2-b3
    Author : Lin Zhe-Hui
    Contact : uegajde@gmail.com
    Github : (none yet)
    Language : Matlab
    License : private

    *SPROUT is still under early development stage, there maybe many structure or variable name change in the future
  
# Introduction
this is a framework designed for data assimilation experiment.  
the SPROUT come with the meaning of sprout of new DA methods  
and wish it be simple, productive, universal, tidy  
 
based on object-oriented programming, it has observation object, model object, analysis object ...etc  
with this, you can quickly test a DA method in several different model with a few adaptation work.  
only need to set-up settings then run same code to generate observation and perform data assimilation

sadly, it was originally design to run all kinds of numerical model, but now not.  
it now only support 1-D model, because of technical and temporal limitation.  
for me, current SPROUT is enough, so this imperfection will not be solved soon. 
or it will be solved in the QG model stage.  

# Release Notes
## 0.7.b3
* new : 
* remove : strategy category, this should be implemented in experiment/operation instead of framework
* fix : a bug in nudging.confidence_weigher