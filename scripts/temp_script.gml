

if (file_exists("serial"))
    {
    controller.serialfile = file_text_open_read("serial");
    controller.serial = file_text_read_string(controller.serialfile);
    file_text_close(controller.serialfile);
    }
else if (os_version != -1) and FS_file_exists("%appdata%\ildagen\serial")
    {
    //show_message("found old");
    oldserial = FS_file_text_open_read("%appdata%\ildagen\serial");
    controller.serial = FS_file_text_read_string(oldserial);
    FS_file_text_close(oldserial);
    controller.serialfile = file_text_open_write("serial");
    file_text_write_string(controller.serialfile,controller.serial);
    file_text_close(controller.serialfile);
    }
else
    {
    with (controller)
        {
        getstr = get_string_async("Exporting requires purchase. Please enter serial key:","")
        dialog = "serial";
        }
    return 0;
    }

if (controller.serial == "") or !(is_string(controller.serial))
    {
    show_message_async("Invalid serial. Contact the author at gitlem@gmail.com if you believe this is wrong.");
    if (file_exists("serial"))
        file_delete("serial");
    return 0;
    }
    
i = 0;    
while (1)
    {
    if (controller.serial == sha1_string_utf8(keyword+string_replace_all(string_format(i,oom,0)," ","0")))
        {
        if !(file_exists("serial"))
            {
            controller.serialfile = file_text_open_write("serial");
            file_text_write_string(controller.serialfile,controller.serial);
            file_text_close(controller.serialfile);
            }
        //http_post_string("http://bitlasers.com/ildagen/auth.php","serial="+string(controller.serial));
        return 1;
        show_debug_message("Successful verification");
        obj_info.registeredstring = "Registered. Thank you for purchasing!";
        obj_info.regflag = 1;
        }
    i++;
    if (i >= (power(10,oom)))
        {
        show_message_async("Invalid serial. Contact the author at gitlem@gmail.com if you believe this is wrong.");
        if (file_exists("serial"))
            file_delete("serial");
        break;
        }
    }
    
return 0;
