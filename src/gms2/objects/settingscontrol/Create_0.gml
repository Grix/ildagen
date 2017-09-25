el_list = -1;

draw_set_font(fnt_tooltip);
menu_string = "   Properties      View      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   Properties   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   View   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   About   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];



