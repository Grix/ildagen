repeat(controller.opt_maxdwell)
    {
    ds_list_add(list_raw,$8000);
    ds_list_add(list_raw,$8000);
    ds_list_add(list_raw,1);
    ds_list_add(list_raw,0);
    }

list_id = ds_list_find_value(el_list,0);
xo = ds_list_find_value(list_id,0);
yo = ds_list_find_value(list_id,1);
xpe = xo+ds_list_find_value(list_id,20);
ype = $ffff-(yo+ds_list_find_value(list_id,21));

var t_index = 20;
while (ype > ($ffff)) or (ype < 0) or (xpe > ($ffff)) or (xpe < 0)
    {
    t_index += 4;
    xpe = xo+ds_list_find_value(list_id,t_index);
    ype = $ffff-(yo+ds_list_find_value(list_id,t_index+1));
    }

blank = ds_list_find_value(list_id,t_index+2);
c = ds_list_find_value(list_id,t_index+3);

opt_dist = point_distance($8000,$8000,xpe,ype);
opt_vectorx = ($8000-xpe)/opt_dist;
opt_vectory = ($8000-ype)/opt_dist;

trav = -controller.opt_maxdist;    
for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
    {
    xp = $8000+opt_vectorx*trav_dist;
    yp = $8000+opt_vectory*trav_dist;
    
    ds_list_add(list_raw,xp);
    ds_list_add(list_raw,yp);
    ds_list_add(list_raw,1);
    ds_list_add(list_raw,0);
    }
    
ds_list_add(list_raw,xpe);
ds_list_add(list_raw,ype);
ds_list_add(list_raw,1);
ds_list_add(list_raw,0);
for (m = 0;m < controller.opt_maxdwell-1;m++)
    {
    ds_list_add(list_raw,xpe);
    ds_list_add(list_raw,ype);
    ds_list_add(list_raw,blank);
    ds_list_add(list_raw,c);
    }
