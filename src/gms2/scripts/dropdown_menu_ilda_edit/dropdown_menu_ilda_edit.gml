ddobj = instance_create_layer(controller.menu_width_start[2],0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 7;
    event_user(1);
    ds_list_add(desc_list,"Undo (Ctrl+Z)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,undo_ilda);
    ds_list_add(hl_list,!ds_list_empty(controller.undo_list));
    ds_list_add(desc_list,"Cut (Ctrl+X)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,cut_object);
    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
    ds_list_add(desc_list,"Copy (Ctrl+C");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,copy_object);
    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
    ds_list_add(desc_list,"Paste (Ctrl+V)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,paste_object);
    ds_list_add(hl_list,(controller.copy_list != -1));
    ds_list_add(desc_list,"Delete (Del)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,delete_object);
    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
    ds_list_add(desc_list,"Select all (Ctrl+A)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_selectall);
    ds_list_add(hl_list,!ds_list_empty(controller.el_list));
    ds_list_add(desc_list,"Deselect all");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,deselect_object);
    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
}
