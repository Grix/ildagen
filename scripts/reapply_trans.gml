//reapplies the object properties

if (maxframes == 1) and (anienable)
    {
    maxframes = 32;
    scope_end = 31;
    refresh_miniaudio_flag = 1;
    
    if (ds_list_size(frame_list) < maxframes)
        repeat (maxframes - ds_list_size(frame_list))
            {
            templist = ds_list_create();
            if (fillframes)
                {
                tempelcount = ds_list_size(ds_list_find_value(frame_list,ds_list_size(frame_list)-1));
                for (u = 0;u < tempelcount;u++)
                    {
                    tempellist = ds_list_create();
                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,ds_list_size(frame_list)-1),u));
                    ds_list_add(templist,tempellist);
                    }
                }
            ds_list_add(frame_list,templist);
            }
    }

for (c = 0; c < ds_list_size(semaster_list); c++)
    {
    selectedelement = ds_list_find_value(semaster_list,c);
    
    //find elements
    temp_undof_list = ds_list_create();
    temp_frame_list = ds_list_create();
    for (i = scope_start;i <= scope_end;i++)
        {
        el_list_temp = ds_list_find_value(frame_list,i);
        for (u = 0;u < ds_list_size(el_list_temp);u++)
            {
            if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
                {
                if (ds_list_empty(temp_frame_list))
                    startframe = i;
                ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
                temp_undo_list = ds_list_create();
                ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
                ds_list_add(temp_undo_list,i);
                ds_list_add(temp_undof_list,temp_undo_list);
                }
            }
        }
    
    ds_list_add(undo_list,"k"+string(temp_undof_list));
    
    
    //walk through frames
    for (i = 0;i < ds_list_size(temp_frame_list);i++)
        {
        new_list = ds_list_find_value(temp_frame_list,i);
        checkpoints = ((ds_list_size(new_list)-50)/6);
        
        startpos[0] = ds_list_find_value(new_list,0);
        startpos[1] = ds_list_find_value(new_list,1);
        endx = ds_list_find_value(new_list,2);
        endy = ds_list_find_value(new_list,3);
        
        if (anienable == 0) or (ds_list_size(temp_frame_list) == 1)
            {
            endx_r = endx+anixtrans;
            endy_r = endy+aniytrans;
            startposx_r = startpos[0]+anixtrans;
            startposy_r  = startpos[1]+aniytrans;
            rot_r = degtorad(anirot);
            scalex_r = scalex;
            scaley_r = scaley;
            }
        else
            {
            t = i/(ds_list_size(temp_frame_list));
            t = (t*anirep)%1;
            if (anifunc = "tri")
                {
                t *= 2;
                if (t > 1)
                    t = 1-(t%1);
                }
            else if (anifunc = "sine")
                {
                t = cos(t*pi*2);
                t *= -1;
                t += 1;
                t /= 2;
                }
            else if (anifunc = "easeout")
                {
                t = sin(t*pi/2);
                }
            else if (anifunc = "easein")
                {
                t = 1-sin(t*pi/2+pi/2);
                }
            else if (anifunc = "bounce")
                {
                t = sin(t*pi);
                }
            else if (anifunc = "easeinout")
                {
                t = sin(t*pi-pi/2);
                t += 1;
                t /= 2;
                }
                
            endx_r = lerp(endx,endx+anixtrans,t);
            endy_r = lerp(endy,endy+aniytrans,t);
            startposx_r = lerp(startpos[0],startpos[0]+anixtrans,t);
            startposy_r  = lerp(startpos[1],startpos[1]+aniytrans,t);
            rot_r = degtorad(lerp(0,anirot,t));
            scalex_r = lerp(1,scalex,t);
            scaley_r = lerp(1,scaley,t);
            }
            
        xmax = -$ffff;
        xmin = $ffff;
        ymax = -$ffff;
        ymin = $ffff;
            
        //walk through points
        for (j = 0; j < checkpoints;j++)
            {
            listpos = 50+j*6;
            
            xp = startpos[0]+ds_list_find_value(new_list,listpos);
            yp = startpos[1]+ds_list_find_value(new_list,listpos+1);
            
            angle = degtorad(point_direction(anchorx,anchory,xp,yp));
            dist = point_distance(anchorx,anchory,xp,yp);
            
            xpnew = anchorx+cos(rot_r-angle)*dist*scalex_r-startpos[0];
            ypnew = anchory+sin(rot_r-angle)*dist*scaley_r-startpos[1];
            
            ds_list_replace(new_list,listpos,xpnew);
            ds_list_replace(new_list,listpos+1,ypnew);
            
            if (xpnew > xmax)
               xmax = xpnew;
            if (xpnew < xmin)
               xmin = xpnew;
            if (ypnew > ymax)
               ymax = ypnew;
            if (ypnew < ymin)
               ymin = ypnew;
            }
            
        /*angle = degtorad(point_direction(anchorx,anchory,startposx_r,startposy_r));
        dist = point_distance(anchorx,anchory,startposx_r,startposy_r);
        
        startposx_r_fix = anchorx+cos(rot_r-angle)*dist*scalex_r-startpos[0];
        startposy_r_fix = anchory+sin(rot_r-angle)*dist*scaley_r-startpos[1];*/
        
        //TODO fix snapping
            
        ds_list_replace(new_list,0,startposx_r);
        ds_list_replace(new_list,1,startposy_r);
        
        /*angle = degtorad(point_direction(anchorx,anchory,endx_r,endy_r));
        dist = point_distance(anchorx,anchory,endx_r,endy_r);
        
        endx_r_fix = anchorx+cos(rot_r-angle)*dist*scalex_r-startpos[0];
        endy_r_fix = anchory+sin(rot_r-angle)*dist*scaley_r-startpos[1];*/
        
        ds_list_replace(new_list,2,endx_r);
        ds_list_replace(new_list,3,endy_r);
        
        ds_list_replace(new_list,4,xmin/$ffff*512);
        ds_list_replace(new_list,5,xmax/$ffff*512);
        ds_list_replace(new_list,6,ymin/$ffff*512);
        ds_list_replace(new_list,7,ymax/$ffff*512);    
        }
    }

frame_surf_refresh = 1;
update_semasterlist_flag = 1;
