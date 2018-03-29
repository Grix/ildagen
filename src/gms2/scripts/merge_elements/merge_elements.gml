
//todo go through all frames

new_list = ds_list_create();
repeat(9)
	ds_list_add(new_list, 0);
ds_list_add(new_list, el_id); 
el_id++;
repeat(10)
	ds_list_add(new_list, 0);

for (j = 0; j < ds_list_size(el_list); j++)
{
	var t_element = el_list[| j];
	if (ds_list_find_index(semaster_list, t_element[| 9]) == -1)
		continue;
			
	xo = t_element[| 0];
	yo = t_element[| 1];
		
	//todo check maxmin coords for each element
			
	for (k = 20; k < ds_list_size(t_element); k += 4)
	{
		if (k == 20)
		{
			ds_list_add(new_list, xo + t_element[| k]);
			ds_list_add(new_list, yo + t_element[| k+1]);
			ds_list_add(new_list, 1);
			ds_list_add(new_list, c_black);
		}
		ds_list_add(new_list, xo + t_element[| k]);
		ds_list_add(new_list, yo + t_element[| k+1]);
		ds_list_add(new_list, t_element[| k+2]);
		ds_list_add(new_list, t_element[| k+3]);
	}
		
	ds_list_delete(el_list, j);
	j--;
}

ds_list_add(el_list, new_list);
ds_list_clear(semaster_list);
ds_list_add(semaster_list, el_id - 1);

//todo undo