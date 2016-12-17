///add_projector(position)

var t_projector = ds_list_create();
ds_list_add(t_projector, controller.el_id);
controller.el_id++;
ds_list_add(t_projector, "Projector");
ds_list_add(t_projector, -1);
ds_list_add(t_projector, "DEFAULT");
ds_list_add(t_projector, ds_list_create());
ds_list_add(seqcontrol.projector_list, t_projector);
if (room == rm_options)
    surface_free(obj_projectors.surf_projectorlist);
