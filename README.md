# gold-prediction
FCNN for gold cost predictions in MATLAB environment

This project allows to predict daily gold cost using provided values of this cost in previous 300 days.
Main file in this repo is "projectv2.m" which contains conections to other functions and which is designed for training fully connected neural network.
Two example files with necesarry data are attached. First one, "danev2" contains gold cost values for training and predicting and the other one "real" contains data which are used in comparison to neural networ output values. It allows to review the efficiency of trained neural network.
So the first step is to run "projectv2.m" file in order to train neural network model and then "predict.m" file which predicts future cost values and presenting the results on figures.
