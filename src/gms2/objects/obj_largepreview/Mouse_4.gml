if (instance_exists(obj_dropdown) || !_visible)
    exit;
seqcontrol.largepreview = !seqcontrol.largepreview;
seqcontrol.frame_surf_refresh = 1;
controller.forceresize = 1;

