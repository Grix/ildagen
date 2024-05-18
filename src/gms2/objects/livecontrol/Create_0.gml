frame_surf_refresh = 0;
image_speed = 0;
tooltip = "";
getint = -1;
getstr = -1;
dialog = "";
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;
doubleclick_mousexprevious = mouse_x;
viewmode = 0;
doubleclick = 0;
filepath = "";
scrollbary = 0;
scrollbarw = 0;
ypos_perm = 0;
scrollbarwidth = 18;
scroll_moving = 0;
selected_slider = -1;

alarm[4] = 300;

playing = 0;
frame = 0;
framehr = 0;
frametotal = 0;
frametotalhr = 0;
maxframes = 1;
frameprev = -1;
selectedfile = -1; // index of filelist, -1 if none selected
highlightfile = -1;
stop_at_play = false;
undo_list = ds_list_create_pool();
redo_list = ds_list_create_pool();
filelist = ds_list_create_pool();
el_list = -1;
midi_keys_pressed = ds_list_create_pool();

masterx = 0;
mastery = 0;
masteralpha = 1;
masterhue = 255;
masterred = 1;
masterblue = 1;
mastergreen = 1;
masterabsrot = pi;

masterx_midi_shortcut = -2;
mastery_midi_shortcut = -2;
masteralpha_midi_shortcut = -2;
masterhue_midi_shortcut = -2;
masterred_midi_shortcut = -2;
masterblue_midi_shortcut = -2;
mastergreen_midi_shortcut = -2;
masterabsrot_midi_shortcut = -2;
speed_adjusted_midi_shortcut = -2;

if (controller.has_midi)
{
	masteralpha_midi_shortcut = 7; // volume ID
}

loadprojectflag = false;

browser_surf = -1;
frame_surf = -1;
frame3d_surf = -1;

target_width_per_cell = 128;
num_grid_columns = 8;
bpm_adjusted = 120;
speed_adjusted = 1;

tlw = 983; //width of grid area
tlh = 570; // height of grid area
tlsurf_y = 137; //start of grid area, seen from outside surface

c_gold = make_colour_rgb(255,220,0);

menu_string = "   File      Edit      View      Settings      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   File   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   Edit   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   View   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];
menu_width[3] = string_width("   Settings   ");
menu_width_start[4] = menu_width_start[3]+menu_width[3];
menu_width[4] = string_width("   About   ");
menu_width_start[5] = menu_width_start[4]+menu_width[4];

