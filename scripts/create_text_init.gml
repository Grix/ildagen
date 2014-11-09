//get and check data
if (ds_list_empty(font_list))
    {
    if (!import_font())
        return 0;
    }

text = get_string("Enter text","");
if (text == "") return 0;

for (i = 0;i <= maxframes;i++)
    xdelta[i] = 0;

//start making elements
for (texti = 1; texti <= string_length(text);texti++)
    {
    letter = string_char_at(text,texti);
    if (ord(letter) != clamp(ord(letter),33,126))
        {
        for (i = 0;i <= maxframes;i++)
            xdelta[i] += font_size*1.3;
        }
    else
        create_element();
    }
    
refresh_surfaces();
