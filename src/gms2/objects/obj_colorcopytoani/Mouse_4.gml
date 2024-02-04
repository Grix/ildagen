if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
	exit;

tempundolist = ds_list_create_pool();
ds_list_add(tempundolist,controller.anienddotscolor);
ds_list_add(tempundolist,controller.anicolor2);
ds_list_add(tempundolist,controller.anicolor1);
ds_list_add(controller.undo_list,"v"+string(tempundolist));

controller.anicolor1 = controller.color1;
controller.anienddotscolor = controller.enddotscolor;
controller.anicolor2 = controller.color2;

update_anicolors();

