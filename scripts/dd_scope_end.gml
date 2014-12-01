with (controller)
    {
    dialog = "scopeend";
    getint = get_integer_async("Enter the ending frame of the animation, between "+string(controller.scope_start+2)+" and "+string(controller.maxframes),controller.frame+1);
    }
