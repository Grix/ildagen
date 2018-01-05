//todo make new palette for ttl sd card using bmp2ild
pal_list = ds_list_create();
pal_list_ttl = ds_list_create();
ini_open("palette.ini");
var t_string;
for (j = 0; j <= 191; j++)
{
    ds_list_add(pal_list, ini_read_real("pal", string(j), 0));
}
for (j = 0; j <= 7*3; j++)
{
    ds_list_add(pal_list_ttl, ini_read_real("pal_ttl", string(j), 0));
}
	
ini_close();

/*ini_open(get_save_filename("",""));
	for (j = 0; j < ds_list_size(pal_list); j++)
	{
	    ini_write_real("pal",string(j),ds_list_find_value(pal_list,j));
	}
	ini_close();*/
log("palette loaded, size: "+string(ds_list_size(pal_list)));
