//checks control bytes at pos i

if (get_byte() != argument0)
{
    show_message_new("Unexpected byte: "+string(i)+" = "+string(get_byte)+". Is this a valid ILDA file?");
    return 0;
}
else 
    return 1;
