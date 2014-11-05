controller.scope_end = clamp(get_integer("Enter the ending frame of the animation, between "+string(controller.scope_start+2)+" and "+string(controller.maxframes)
                                            ,controller.frame+1),controller.scope_start+2,controller.maxframes)-1;
