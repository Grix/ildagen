with(controller)
    {
    read_ilda_init();
    ds_stack_push(undo_list,el_id);
    el_id++;
    }