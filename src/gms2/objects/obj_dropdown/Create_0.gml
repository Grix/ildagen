if (controller.dialog_open) 
    instance_destroy();
controller.menu_open = 1;

rdy = 0;
selected = noone;
y += 23*controller.dpi_multiplier;

with (obj_dropdown)
{
    if (other.id != id)
        instance_destroy();
}

with (controller)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}
    
//items
desc_list = ds_list_create();
sep_list = ds_list_create();
scr_list = ds_list_create();
hl_list = ds_list_create();

//font
font = fnt_tooltip;

//size
total_width = 200*controller.dpi_multiplier;
item_padding = 8*controller.dpi_multiplier;        //space around each item
highlight_padding = 3*controller.dpi_multiplier;   //extra padding for highlight indicator
highlight_rad = 4*controller.dpi_multiplier;       //Radius for round rect highlight

//colors
bak_color = $151515;
border_color = c_dkgray;
highlight_color = c_teal;
icon_color = c_ltgray;
separator_color = c_dkgray;
text_color = $828282;

bak_alpha = 1;