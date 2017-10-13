if (debug_mode)
    log("prepare_output_points_unopt");

listsize = ((ds_list_size(list_id)-20)/4);
maxpoints_static += listsize;
if (listsize >= 1)
    return true;
else
    return false;
