//initializes parsing of an ilda file
//arg0 is scanner number
//return 1 if successful

filename = argument0;
if string_length(filename)
    {
    ild_file = buffer_load(filename);
    file_size = buffer_get_size(ild_file);
    }
else
    return 0;
    
i = 0;
if !is_wrong($49)
    return 0;i++;
if !is_wrong($4C)
    return 0;i++; 
if !is_wrong($44) 
    return 0;i++;
if !is_wrong($41) 
    return 0;i++;
if !is_wrong($0)
    return 0;i++;
if !is_wrong($0)
    return 0;i++;
if !is_wrong($0)
    return 0;i=0;


filename = "";

i = 0;
format = 0;
    
ild_list = ds_list_create();

do
    {
    if (read_ilda_header_first()) 
        return 0;
    }
until (format != 2)

read_ilda_frame();

return 1;
