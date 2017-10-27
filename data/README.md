This folder contains data relevant to the current project.

- original_data: this file contains the original data from the experiment. It has not been edited in any way. Every line of the file contains an instance of the experiment and each columm (columns are separated by spaces) contains one time measurement

- data_na_filled: this file adds padding columns (with value 0) to shorter experiments in order to be able to conveniently read the data as an n*m matrix in julia

- skipped_corrected: some of the experiments skipped some measurements, making it hard to use the data for some particular likelihood functions. This file was manually prepared to replace missing measurements by 0 in order to be able to use later measurements in julia
  		     TODO: this could and should be done automatically


TODO: The original_data file was edited by mistake, the current version of it should be saved in another file, the editing process should be described and the original_data file should be restored

