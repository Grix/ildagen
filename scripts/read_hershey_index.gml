//reads a hershey font file and returns the index font list

hershey_file = file_bin_open("hershey",0);

frame_list_parse = ds_list_create();

file_bin_seek(hershey_file,ds_list_find_value(hershey_index_list,hershey_selected));

maxglyphpoints = 0;
maxglyphpoints += 100*real(chr(file_bin_read_byte(hershey_file)));//  string_char_at(hershey_string,c));
maxglyphpoints += 10*real(chr(file_bin_read_byte(hershey_file)));
maxglyphpoints += real(chr(file_bin_read_byte(hershey_file)));

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

constrxchar = file_bin_read_byte(hershey_file);
constrychar = file_bin_read_byte(hershey_file);
constrx = max((constrxchar - $52),1);
constry = max((constrychar - $52),1);

repeat(maxglyphpoints-1)
    {
    nextcharx = file_bin_read_byte(hershey_file);
    nextchary = file_bin_read_byte(hershey_file);
    if (nextcharx == $20) and (nextchary == $52)
        {
        blank = 1;
        continue;
        }
    nextpointx = (nextcharx - $52)/constrx*900//*3000;///constrx*32500;
    nextpointy = (nextchary - $52)/constrx*900//*3000;///constry*32500;
    
    ds_list_add(frame_list_parse,nextpointx);
    ds_list_add(frame_list_parse,nextpointy);
    ds_list_add(frame_list_parse,blank);
    blank = 0;
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    }
    
file_bin_close(hershey_file);

//interpolate
new_list = frame_list_parse;
checkpoints = ((ds_list_size(new_list)-50)/6);

for (j = 0; j < (checkpoints-1);j++)
    {
    temppos = 50+j*6;
    
    if  (ds_list_find_value(new_list,temppos+8) == 1)
        continue;
        
    if  (ds_list_find_value(new_list,temppos+9) == 0) &&
        (ds_list_find_value(new_list,temppos+10) == 0) &&
        (ds_list_find_value(new_list,temppos+11) == 0)
            {
            //show_debug_message("black")
            ds_list_replace(new_list,temppos+2,1);
            continue;
            }
        
    length = point_distance( ds_list_find_value(new_list,temppos)
                            ,ds_list_find_value(new_list,temppos+1)
                            ,ds_list_find_value(new_list,temppos+6)
                            ,ds_list_find_value(new_list,temppos+7));
    
    if (length < opt_maxdist*phi) continue;
    
    steps = length / opt_maxdist;
    stepscount = round(steps-1);
    tempx0 = ds_list_find_value(new_list,temppos);
    tempy0 = ds_list_find_value(new_list,temppos+1);
    tempvectx = (ds_list_find_value(new_list,temppos+6)-tempx0)/steps;
    tempvecty = (ds_list_find_value(new_list,temppos+7)-tempy0)/steps;
    tempblank = ds_list_find_value(new_list,temppos+8);
    tempc1 = ds_list_find_value(new_list,temppos+9);
    tempc2 = ds_list_find_value(new_list,temppos+10);
    tempc3 = ds_list_find_value(new_list,temppos+11);
           
    repeat(floor(stepscount))
        {
        newx = tempx0+tempvectx*(stepscount);
        newy = tempy0+tempvecty*(stepscount);
        ds_list_insert(new_list,temppos+6,tempc3);
        ds_list_insert(new_list,temppos+6,tempc2);
        ds_list_insert(new_list,temppos+6,tempc1);
        ds_list_insert(new_list,temppos+6,tempblank);
        ds_list_insert(new_list,temppos+6,newy);
        ds_list_insert(new_list,temppos+6,newx);
        j++;
        checkpoints++;
        stepscount--;
        }
    
    }

return frame_list_parse;
