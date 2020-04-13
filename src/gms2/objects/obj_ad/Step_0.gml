highlight_close = false;

x = round(window_get_width()/2 - 350*controller.dpi_multiplier);
y = round(window_get_height()/2 - 200*controller.dpi_multiplier);

if (window_mouse_get_x() >= (x+660*controller.dpi_multiplier)) && (window_mouse_get_x() <= (x+700*controller.dpi_multiplier)) && (window_mouse_get_y() >= y-10*controller.dpi_multiplier) && (window_mouse_get_y() <= (y+20*controller.dpi_multiplier))
{
    controller.tooltip = "Click to close advertisement.";
    highlight_close = true;
    if (mouse_check_button_pressed(mb_left))
    {
        controller.adclosed = true;
        instance_destroy();
    }
}
else if (window_mouse_get_x() >= x) && (window_mouse_get_x() <= (x+700*controller.dpi_multiplier)) && (window_mouse_get_y() >= (y+20*controller.dpi_multiplier)) && (window_mouse_get_y() <= (y+420*controller.dpi_multiplier))
{
    controller.tooltip = "More info.";
    if (mouse_check_button_pressed(mb_left))
    {
        if (ad == spr_ad1)
            url_open_new("https://bitlasers.com/shop/lasershowgen/");
        else if (ad == spr_ad2)
            url_open_new("https://www.reddit.com/r/lasershowgen");
        else if (ad == spr_ad3)
            url_open_new("https://bitlasers.com/helios-laser-dac/");
        else if (ad == spr_ad4)
            url_open_new("http://pages.bitlasers.com/lasershowgen/advertising");
    
        ddobj = instance_create_layer(0,0,"foreground",obj_dropdown);
        with (ddobj)
        {
            num = 0;
            event_user(1);
        }
    }
}
else if (mouse_check_button_pressed(mb_left))
{
    ddobj = instance_create_layer(0,0,"foreground",obj_dropdown);
    with (ddobj)
    {
        num = 0;
        event_user(1);
    }
}

