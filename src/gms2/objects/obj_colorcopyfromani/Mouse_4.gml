if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

tempundolist = ds_list_create();
ds_list_add(tempundolist,controller.enddotscolor);
ds_list_add(tempundolist,controller.color2);
ds_list_add(tempundolist,controller.color1);
ds_list_add(controller.undo_list,"b"+string(tempundolist));

controller.color1 = controller.anicolor1;
controller.enddotscolor = controller.anienddotscolor;
controller.color2 = controller.anicolor2;

update_colors();

