with (controller)
    {
    dialog = "scopestart";
    getint = get_integer_async("Enter the starting frame of the animation, between 1 and "+string(controller.scope_end),controller.frame+1);
    }