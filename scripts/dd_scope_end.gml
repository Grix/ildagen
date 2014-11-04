controller.scope_end = clamp(get_integer("Enter the starting frame of the animation, between "+string(controller.scope_start+2)+" and "+string(controller.maxframes)
                                            ,controller.scope_end+1),controller.scope_start+2,controller.maxframes)-1;
