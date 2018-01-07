//todo make new palette for ttl sd card using bmp2ild
pal_list_ilda = ds_list_create();
pal_list_ttl = ds_list_create();
ini_open("palette.ini");
for (j = 0; j <= 191; j++)
{
    ds_list_add(pal_list_ilda, ini_read_real("pal", string(j), 0));
}
ini_close();

for (j = 0; j <= 191; j++)
{
    ds_list_add(pal_list_ttl, 0);
}
pal_list_ttl[| 1*3 + 0] = 255;
pal_list_ttl[| 1*3 + 1] = 255;
pal_list_ttl[| 1*3 + 2] = 255;
pal_list_ttl[| 2*3 + 0] = 255;
pal_list_ttl[| 2*3 + 1] = 0;
pal_list_ttl[| 2*3 + 2] = 0;
pal_list_ttl[| 3*3 + 0] = 255;
pal_list_ttl[| 3*3 + 1] = 255;
pal_list_ttl[| 3*3 + 2] = 0;
pal_list_ttl[| 4*3 + 0] = 0;
pal_list_ttl[| 4*3 + 1] = 255;
pal_list_ttl[| 4*3 + 2] = 0;
pal_list_ttl[| 5*3 + 0] = 0;
pal_list_ttl[| 5*3 + 1] = 255;
pal_list_ttl[| 5*3 + 2] = 255;
pal_list_ttl[| 6*3 + 0] = 0;
pal_list_ttl[| 6*3 + 1] = 0;
pal_list_ttl[| 6*3 + 2] = 255;
pal_list_ttl[| 7*3 + 0] = 255;
pal_list_ttl[| 7*3 + 1] = 0;
pal_list_ttl[| 7*3 + 2] = 255;


/*ini_open(get_save_filename("",""));
	for (j = 0; j < ds_list_size(pal_list_ttl); j++)
	{
	    ini_write_real("pal_ttl", string(j), ds_list_find_value(pal_list_ttl,j));
	}
ini_close();*/

log("palette loaded, size: "+string(ds_list_size(pal_list_ilda)));

pal_list = pal_list_ilda;
ttlpalette = 0;