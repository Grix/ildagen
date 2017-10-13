xmax = -$ffff;
xmin = $ffff;
ymax = -$ffff;
ymin = $ffff;
for (u = 0; u < ds_list_size(el_list);u++)
{
    templist = ds_list_find_value(el_list,u);
    elid_temp = ds_list_find_value(templist,9);
    
    for (j = 0;j < ds_list_size(semaster_list);j++)
    {
        if (elid_temp == ds_list_find_value(semaster_list,j))
        {
            xo = ds_list_find_value(templist,0)/$ffff*512;
            yo = ds_list_find_value(templist,1)/$ffff*512;
            if (xmin > xo + (ds_list_find_value(templist,4)))
                xmin = xo + (ds_list_find_value(templist,4));
            if (ymin > yo + (ds_list_find_value(templist,6)))
                ymin = yo + (ds_list_find_value(templist,6));
            if (xmax < xo + (ds_list_find_value(templist,5)))
                xmax = xo + (ds_list_find_value(templist,5));
            if (ymax < yo + (ds_list_find_value(templist,7)))
                ymax = yo + (ds_list_find_value(templist,7));
        }
    }
}
rectxmax = xmax;
rectxmin = xmin;
rectymax = ymax;
rectymin = ymin;

update_semasterlistflag = 0;
