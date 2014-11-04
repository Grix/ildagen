controller.scope_start = clamp(get_integer("Enter the starting frame of the animation, between 1 and "+string(controller.scope_end)
                                            ,controller.scope_start+1),1,controller.scope_end)-1;
