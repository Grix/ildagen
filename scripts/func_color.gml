if (n/checkpoints != ML_VM_GetVarReal(parser_cb,"point"))
    {
    ML_VM_SetVarReal(parser_cb,"point",n/checkpoints);
    
    if (placing == "line")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+n*vector[0]*128);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+n*vector[1]*128);
        }
    else if (placing == "func")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+result_x);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+result_y);
        }
    else if (placing == "circle")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+cos(startrad+ 2*pi/checkpoints*n)*radius);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+sin(startrad+ 2*pi/checkpoints*n)*radius);
        }
    else if (placing == "wave")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+pointx*128);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+pointy*128);
        }
    else if (placing == "curve")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+pointx*128);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+pointy*128);
        }
    else if (placing == "free")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+ds_list_find_value(free_list,2*n)*128);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+ds_list_find_value(free_list,2*n+1)*128);
        }
    else if (placing == "letter")
        {
        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
        }
    }
    
result_1 = ML_Execute(parser_cb,compiled_1);
if (!ML_ResObj_HasAnswer(result_1))
    {
    show_message_async("Unexpected value for COLOR 1 at point="+string(n/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_1);
    ML_CompileCleanup(compiled_1);
    ML_CompileCleanup(compiled_2);
    ML_CompileCleanup(compiled_3);
    return 0;
    }
result_2 = ML_Execute(parser_cb,compiled_2);
if (!ML_ResObj_HasAnswer(result_2))
    {
    show_message_async("Unexpected value for COLOR 2 at point="+string(n/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_1);
    ML_ResObj_Cleanup(result_2);
    ML_CompileCleanup(compiled_1);
    ML_CompileCleanup(compiled_2);
    ML_CompileCleanup(compiled_3);
    return 0;
    }
result_3 = ML_Execute(parser_cb,compiled_3);
if (!ML_ResObj_HasAnswer(result_3))
    {
    show_message_async("Unexpected value for COLOR 3 at point="+string(n/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_1);
    ML_ResObj_Cleanup(result_2);
    ML_ResObj_Cleanup(result_3);
    ML_CompileCleanup(compiled_1);
    ML_CompileCleanup(compiled_2);
    ML_CompileCleanup(compiled_3);
    return 0;
    }
    
answer_1 = ML_ResObj_GetFinalAnswer(result_1);
answer_2 = ML_ResObj_GetFinalAnswer(result_2);
answer_3 = ML_ResObj_GetFinalAnswer(result_3);
ML_ResObj_Cleanup(result_1);
ML_ResObj_Cleanup(result_2);
ML_ResObj_Cleanup(result_3);

if (colormode2 == 0)
    {
    c[2] = clamp(answer_1,0,255);
    c[1] = clamp(answer_2,0,255);
    c[0] = clamp(answer_3,0,255);
    }
else if (colormode2 == 1)
    {
    colortemp = make_colour_hsv(clamp(answer_1,0,255),clamp(answer_2,0,255),clamp(answer_3,0,255));
    c[2] = colour_get_red(colortemp);
    c[1] = colour_get_green(colortemp);
    c[0] = colour_get_blue(colortemp);
    }

return 1;