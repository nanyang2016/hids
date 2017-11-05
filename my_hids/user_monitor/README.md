###### BRUTE_FORCE DETECT

    This mod can detect ssh brute force behavior

###### FILE
  
    bin		#detect script
  
    conf	#config file
  
    log		#running log and alarm

###### CONFIGURE 

    [monitor_file]		[/var/log/auth.log]	#monitor auth.log to find fail login logs.

    [key_words]			[Failed password]	#fail login key words

    [limit_time]		[60]			#we judge have error login time greater than limit_error_num in limit_time is brute force behavior,unit is sec.

    [limit_error_num]		[10]

    [scan_frequency]		[10]			#scan monitor file frequency

    [white_list]		[localhost]		#white list
