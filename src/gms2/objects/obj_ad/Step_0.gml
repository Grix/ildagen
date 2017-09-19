highlight_close = false;

if (mouse_x >= (x+670)) && (mouse_x <= (x+700)) && (mouse_y >= y) && (mouse_y <= (y+20))
{
    controller.tooltip = "Click to close advertisement.";
    highlight_close = true;
    if (mouse_check_button_pressed(mb_left))
    {
        controller.adclosed = true;
        instance_destroy();
    }
}
else if (mouse_x >= x) && (mouse_x <= (x+700)) && (mouse_y >= (y+20)) && (mouse_y <= (y+420))
{
    controller.tooltip = "More info.";
    if (mouse_check_button_pressed(mb_left))
    {
        if (ad == spr_ad1)
            url_open_new("http://bitlasers.com/opencart/index.php?route=product/product&product_id=82");
        else if (ad == spr_ad2)
            url_open_new("https://www.reddit.com/r/lasershowgen");
        else if (ad == spr_ad3)
            url_open_new("http://pages.bitlasers.com/helios/");
        else if (ad == spr_ad4)
            url_open_new("http://pages.bitlasers.com/lasershowgen/advertising");
    
        ddobj = instance_create_layer(0,0,"foreground",oDropDown);
        with (ddobj)
        {
            num = 0;
            event_user(1);
        }
    }
}
else if (mouse_check_button_pressed(mb_left))
{
    ddobj = instance_create_layer(0,0,"foreground",oDropDown);
    with (ddobj)
    {
        num = 0;
        event_user(1);
    }
}

