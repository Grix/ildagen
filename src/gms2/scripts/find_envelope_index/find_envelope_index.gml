///arg0 = time_list, arg1 = frame

//binary search algo, set t_index to the current cursor pos
var imin = 0;
var imax = ds_list_size(argument0)-1;
if (imax < 0)
	return 0;
	
var imid;
while (imin <= imax)
{
	imid = floor(mean(imin,imax));
	if (ds_list_find_value(argument0,imid) <= argument1)
	{
	    var valnext = ds_list_find_value(argument0,imid+1);
	    if (is_undefined(valnext)) or (valnext >= argument1)
	        break;
	    else
	        imin = imid+1;
	}
	else
	    imax = imid-1;
}
return imid;