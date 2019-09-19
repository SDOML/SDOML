This gitlab repositery contains python and IDL scripts for getting and processing SDO/AIA and SDO/HMI .fits files to .npz files that are ready for machine learning researches (SDO Machine Learning Dataset). For more details about this dataset, please refer to the following paper:

"A Machine-learning Data Set Prepared from the NASA Solar Dynamics Observatory Mission"
http://adsabs.harvard.edu/abs/2019ApJS..242....7G

A brief description about each script:

- aia_fits_to_np.py 	  for processing the AIA synoptic data to npz files
- save_degrad.pro	  for obtaining the AIA degradation curves of different wavebands
- hmi_getfits.pro	  for getting the HMI vector magnetic field data in fits format
- hmi_fits_to_np.py	  for processing the HMI vector data to npz files
