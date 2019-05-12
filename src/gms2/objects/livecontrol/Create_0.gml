frame_surf_refresh = 0;
image_speed = 0;
tooltip = "";
getint = -1;
getstr = -1;
dialog = "";
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;
viewmode = 0;
doubleclick = 0;
filepath = "";

alarm[4] = 300;

playing = 0;
frame = 0;
framehr = 0;
maxframes = 1;
frameprev = -1;
playingfile = -1; // index of filelist, -1 if none selected
highlightfile = -1;
undo_list = ds_list_create();
filelist = ds_list_create();
el_list = ds_list_create();
frame_list = ds_list_create();

browser_surf = -1;
frame_surf = -1;
frame3d_surf = -1;

target_width_per_cell = 128;

tlw = 983; //width of grid area
tlh = 570; // height of grid area
tlsurf_y = 137; //start of grid area, seen from outside surface

c_gold = make_colour_rgb(255,220,0);

menu_string = "   File      Properties      Edit      View      Settings      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   File   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   Properties   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   Edit   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];
menu_width[3] = string_width("   View   ");
menu_width_start[4] = menu_width_start[3]+menu_width[3];
menu_width[4] = string_width("   Settings   ");
menu_width_start[5] = menu_width_start[4]+menu_width[4];
menu_width[5] = string_width("   About   ");
menu_width_start[6] = menu_width_start[5]+menu_width[5];

