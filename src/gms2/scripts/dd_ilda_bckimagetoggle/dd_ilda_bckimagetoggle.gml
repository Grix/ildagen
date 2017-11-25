if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version");
    exit;
}


bckimage = !bckimage;

if (bckimage)
{
    bckfile = get_open_filename("Image files|*.png;*.jpg;*.gif","");
    if string_length(bckfile) 
    {
        bck_bckimage = sprite_add(bckfile,1,0,0,0,0);
        if (sprite_get_width(bck_bckimage) > sprite_get_height(bck_bckimage))
        {
            bckimage_width = 1;
            bckimage_height = 1/sprite_get_width(bck_bckimage)*sprite_get_height(bck_bckimage);
            //todo make this better for scalability:
			bckimage_top = (1-bckimage_height)/2;
            bckimage_left = 0;
        }
        else
        {
            bckimage_height = 1;
            bckimage_width = 1/sprite_get_height(bck_bckimage)*sprite_get_width(bck_bckimage);
            bckimage_top = 0;
            bckimage_left = (1-bckimage_width)/2;
        }
    }
    else
        bckimage = 0;
}
else
{
    if (sprite_exists(bck_bckimage))
        sprite_delete(bck_bckimage);
}
