controller.scope_start = clamp(get_integer("Enter the starting frame of the animation, between 1 and "+string(controller.scope_end)
                                            ,controller.frame+1),1,controller.scope_end)-1;
controller.frame = controller.scope_start;
controller.framehr = controller.scope_start;
with (controller) refresh_surfaces();
