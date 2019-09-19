;Get HMI fits files and convert them to bx, by, and bz components

;set start time
t0='2010-05-01T00:00:00'

;set end time
t1='2018-08-16T23:59:59'

ssw_jsoc_time2data, t0, t1, index,fnames,$
                   ds='hmi.B_720s',$
                   /jsoc2,/silent,/local_files,/files_only

ssw_jsoc_time2data, t0, t1, index1,fnames1,$
                   ds='hmi.B_720s',segment='disambig',$
                   /jsoc2,/silent,/local_files,/files_only

MM=n_elements(fnames)

for i=0,MM-1 do begin

   if index[i].QUALITY eq 0 then begin

      f_loc=STRSPLIT(fnames[i],'/',/EXTRACT)
      file_inclination=fnames[i]
      file_azimuth='/'+f_loc[0]+'/'+f_loc[1]+'/'+f_loc[2]+'/'+'azimuth.fits'
      file_field='/'+f_loc[0]+'/'+f_loc[1]+'/'+f_loc[2]+'/'+'field.fits'
      file_disambig=fnames1[i]

      read_sdo,file_azimuth,oindex,odata_azi,/uncomp_delete
      read_sdo,file_disambig,oindex,odata_disambig,/uncomp_delete
      read_sdo,file_inclination,oindex,odata_inclination,/uncomp_delete
      read_sdo,file_field,oindex,odata_field,/uncomp_delete
      hmi_disambig,odata_azi,odata_disambig,2

      bad_index=where(odata_field lt -1.e7)
      bx=odata_field*sin(odata_inclination*!dtor)*sin(odata_azi*!dtor)
      by=-odata_field*sin(odata_inclination*!dtor)*cos(odata_azi*!dtor)
      bz=odata_field*cos(odata_inclination*!dtor)

      bx[bad_index]=-2.e7 
      by[bad_index]=-2.e7
      bz[bad_index]=-2.e7

      aia_prep,index[i],bx,nindex,ndata,/cubic
      bx[bad_index]=0.0
      minmax_ref=minmax(bx)
      bad_points=where(ndata gt minmax_ref[1] or ndata lt minmax_ref[0])
      ndata[bad_points]=0.0
      mwritefits,nindex,ndata,outfile='temp.fits'
      read_sdo,'temp.fits',findex,fdata,outsize=[512,512],/uncomp_delete
      ftemp=strsplit(findex.T_REC,'_',escape='.:',/extract)
      mwritefits,findex,fdata,outfile='hmi.M_720s.'+ftemp[0]+'_'+ftemp[1]+'_bx.fits'

      aia_prep,index[i],by,nindex,ndata,/cubic
      by[bad_index]=0.0
      minmax_ref=minmax(by)
      bad_points=where(ndata gt minmax_ref[1] or ndata lt minmax_ref[0])
      ndata[bad_points]=0.0
      mwritefits,nindex,ndata,outfile='temp.fits'
      read_sdo,'temp.fits',findex,fdata,outsize=[512,512],/uncomp_delete
      ftemp=strsplit(findex.T_REC,'_',escape='.:',/extract)
      mwritefits,findex,fdata,outfile='hmi.M_720s.'+ftemp[0]+'_'+ftemp[1]+'_by.fits'

      aia_prep,index[i],bz,nindex,ndata,/cubic
      bz[bad_index]=0.0
      minmax_ref=minmax(bz)
      bad_points=where(ndata gt minmax_ref[1] or ndata lt minmax_ref[0])
      ndata[bad_points]=0.0
      mwritefits,nindex,ndata,outfile='temp.fits'
      read_sdo,'temp.fits',findex,fdata,outsize=[512,512],/uncomp_delete
      ftemp=strsplit(findex.T_REC,'_',escape='.:',/extract)
      mwritefits,findex,fdata,outfile='hmi.M_720s.'+ftemp[0]+'_'+ftemp[1]+'_bz.fits'
    endif

endfor

end
