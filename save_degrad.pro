; Get and save the AIA degradation curves for different wavebands.

aia_bp_get_corrections_plot,version=8,corr_euv=corr_euv,corr_uv=corr_uv
mm=n_elements(corr_uv.utc)
dummy_factor=fltarr(mm)
dummy_factor[0:mm-1]=1.0

write_csv,'degrad_94.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,0]
write_csv,'degrad_131.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,1]
write_csv,'degrad_171.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,2]
write_csv,'degrad_193.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,3]
write_csv,'degrad_211.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,4]
write_csv,'degrad_304.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,5]
write_csv,'degrad_335.csv',corr_euv.UTC,corr_euv.EA_OVER_EA0[*,6]
write_csv,'degrad_1600.csv',corr_uv.UTC,corr_uv.EA_OVER_EA0[*,0]
write_csv,'degrad_1700.csv',corr_uv.UTC,corr_uv.EA_OVER_EA0[*,1]
write_csv,'degrad_4500.csv',corr_uv.UTC,dummy_factor

end
