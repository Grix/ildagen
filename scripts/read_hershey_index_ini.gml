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
repeat (10) ds_list_add(frame_list_parse,0); 
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
    ds_list_add(frame_list_parse,c_white);
    
    }
    
ini_close();

//interpolate
new_list_parse = frame_list_parse;
checkpoints = ((ds_list_size(new_list_parse)-20)/6);

for (j = 0; j < (checkpoints-1);j++)
    {
    temppos = 20+j*6;
    
    //if  (ds_list_find_value(new_list_parse,temppos+8) == 1)
    //    continue;
        
    length = point_distance( ds_list_find_value(new_list_parse,temppos)
                            ,ds_list_find_value(new_list_parse,temppos+1)
                            ,ds_list_find_value(new_list_parse,temppos+4)
                            ,ds_list_find_value(new_list_parse,temppos+5));
    
    if (length < resolution*phi) continue;
    
    steps = length / resolution;
    stepscount = round(steps-1);
    tempx0 = ds_list_find_value(new_list_parse,temppos);
    tempy0 = ds_list_find_value(new_list_parse,temppos+1);
    tempvectx = (ds_list_find_value(new_list_parse,temppos+4)-tempx0)/steps;
    tempvecty = (ds_list_find_value(new_list_parse,temppos+5)-tempy0)/steps;
    tempblank = ds_list_find_value(new_list_parse,temppos+6);
    tempc = ds_list_find_value(new_list_parse,temppos+7);
           
    repeat(floor(stepscount))
        {
        newx = tempx0+tempvectx*(stepscount);
        newy = tempy0+tempvecty*(stepscount);
        ds_list_insert(new_list_parse,temppos+4,tempc);
        ds_list_insert(new_list_parse,temppos+4,tempblank);
        ds_list_insert(new_list_parse,temppos+4,newy);
        ds_list_insert(new_list_parse,temppos+4,newx);
        j++;
        checkpoints++;
        stepscount--;
        }
    
    }

return frame_list_parse;
