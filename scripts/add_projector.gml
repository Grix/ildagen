///add_projector(position)

var t_projector = ds_list_create();
ds_list_add(t_projector, controller.el_id);
controller.el_id++;
ds_list_add(t_projector, "Projector "+string(controller.el_id));
ds_list_add(t_projector, ds_list_create());

if (argument[0] == -1)
    ds_list_add(seqcontrol.projector_list, t_projector);
else if (argument[0] < ds_list_size(seqcontrol.projector_list))
    ds_list_insert(seqcontrol.projector_list, argument[0], t_projector);
    
projectorlist_update();
