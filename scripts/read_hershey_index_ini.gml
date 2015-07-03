//reads a hershey font file and returns the index font list

frame_list_parse = ds_list_create();

ini_open("hershey.ini");

maxglyphpoints = ini_read_real(string(argument0),"n",0);
hershey_string = ini_read_string(string(argument0),"s","");

ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0); 
ds_list_add(frame_list_parse,el_id); //id
repeat (40) ds_list_add(frame_list_parse,0); 
blank = 0;

j = 1;
constrxchar = ord(string_char_at(hershey_string,j));
j++;
constrychar = ord(string_char_at(hershey_string,j));
j++;
constrx = max((constrxchar - $52),1);
constry = max((constrychar - $52),1);

/*if (maxglyphpoints == 1)
    {
    nextcharx = file_bin_read_byte(hershey_file);
    nextchary = file_bin_read_byte(hershey_file);
    nextpointx = (nextcharx - $52)/constrx/1.2;
    nextpointy = (nextchary - $52)/constrx/1.2;
    
    repeat (2)
        {
        ds_list_add(frame_list_parse,nextpointx);
        ds_list_add(frame_list_parse,nextpointy);
        ds_list_add(frame_list_parse,blank);
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        }
    }
else*/ 
/*show_debug_message(hershey_string)
show_debug_message(string_char_at(hershey_string,16))*/
//show_debug_message(maxglyphpoints-1)
repeat(maxglyphpoints-1)
    {
    if ( j > (maxglyphpoints)*2) break;
    nextcharx = ord(string_char_at(hershey_string,j));
    j++;
    nextchary = ord(string_char_at(hershey_string,j));
    j++;
    if (nextcharx == $20) and (nextchary == $52)
        {
        blank = 1;
        continue;
        }
    nextpointx = (nextcharx - $52)/constrx*600;
    nextpointy = (nextchary - $52)/constrx*600;
    
    ds_list_add(frame_list_parse,nextpointx);
    ds_list_add(frame_list_parse,nextpointy);
    ds_list_add(frame_list_parse,blank);
    blank = 0;
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    
    }
    
ini_close();

//interpolate
new_list_parse = frame_list_parse;
checkpoints = ((ds_list_size(new_list_parse)-50)/6);

for (j = 0; j < (checkpoints-1);j++)
    {
    temppos = 50+j*6;
    
    if  (ds_list_find_value(new_list_parse,temppos+8) == 1)
        continue;
        
    /*if  (ds_list_find_value(new_list_parse,temppos+9) == 0) &&
        (ds_list_find_value(new_list_parse,temppos+10) == 0) &&
        (ds_list_find_value(new_list_parse,temppos+11) == 0)
            {
            ds_list_replace(new_list_parse,temppos+2,1);
            continue;
            }*/
        
    length = point_distance( ds_list_find_value(new_list_parse,temppos)
                            ,ds_list_find_value(new_list_parse,temppos+1)
                            ,ds_list_find_value(new_list_parse,temppos+6)
                            ,ds_list_find_value(new_list_parse,temppos+7));
    
    if (length < resolution*phi) continue;
    
    steps = length / resolution;
    stepscount = round(steps-1);
    tempx0 = ds_list_find_value(new_list_parse,temppos);
    tempy0 = ds_list_find_value(new_list_parse,temppos+1);
    tempvectx = (ds_list_find_value(new_list_parse,temppos+6)-tempx0)/steps;
    tempvecty = (ds_list_find_value(new_list_parse,temppos+7)-tempy0)/steps;
    tempblank = ds_list_find_value(new_list_parse,temppos+8);
    tempc1 = ds_list_find_value(new_list_parse,temppos+9);
    tempc2 = ds_list_find_value(new_list_parse,temppos+10);
    tempc3 = ds_list_find_value(new_list_parse,temppos+11);
           
    repeat(floor(stepscount))
        {
        newx = tempx0+tempvectx*(stepscount);
        newy = tempy0+tempvecty*(stepscount);
        ds_list_insert(new_list_parse,temppos+6,tempc3);
        ds_list_insert(new_list_parse,temppos+6,tempc2);
        ds_list_insert(new_list_parse,temppos+6,tempc1);
        ds_list_insert(new_list_parse,temppos+6,tempblank);
        ds_list_insert(new_list_parse,temppos+6,newy);
        ds_list_insert(new_list_parse,temppos+6,newx);
        j++;
        checkpoints++;
        stepscount--;
        }
    
    }

return frame_list_parse;