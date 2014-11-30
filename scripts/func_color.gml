if (n/checkpoints != ML_VM_GetVarReal(parser_cb,"point"))
    {
    ML_VM_SetVarReal(parser_cb,"point",n/checkpoints);
    
    if (placing == "line")
        {
        ML_VM_SetVarReal(parser_cb,"x",n*vector[0]*128);
        ML_VM_SetVarReal(parser_cb,"y",n*vector[1]*128);
        }
    else if (placing == "func")
        {
        ML_VM_SetVarReal(parser_cb,"x",result_x);
        ML_VM_SetVarReal(parser_cb,"y",result_y);
        }
    else if (placing == "circle")
        {
        ML_VM_SetVarReal(parser_cb,"x",cos(startrad+ 2*pi/checkpoints*n)*radius);
        ML_VM_SetVarReal(parser_cb,"y",sin(startrad+ 2*pi/checkpoints*n)*radius);
        }
    else if (placing == "wave")
        {
        ML_VM_SetVarReal(parser_cb,"x",pointx*128);
        ML_VM_SetVarReal(parser_cb,"y",pointy*128);
        }
    else if (placing == "curve")
        {
        ML_VM_SetVarReal(parser_cb,"x",pointx*128);
        ML_VM_SetVarReal(parser_cb,"y",pointy*128);
        }
    else if (placing == "free")
        {
        ML_VM_SetVarReal(parser_cb,"x",ds_list_find_value(free_list,2*n)*128);
        ML_VM_SetVarReal(parser_cb,"y",ds_list_find_value(free_list,2*n+1)*128);
        }
    else if (placing == "letter")
        {
        ML_VM_SetVarReal(parser_cb,"x",(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
        ML_VM_SetVarReal(parser_cb,"y",(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
        }
    }
    
result_1 = ML_Execute(parser_cb,compiled_1);
if (!ML_ResObj_HasAnswer(result_1))
    {
    show_message("Unexpected value for COLOR 1 at point="+string(n/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_1);
    ML_CompileCleanup(compiled_1);
    ML_CompileCleanup(compiled_2);
    ML_CompileCleanup(compiled_3);
    return 0;
    }
result_2 = ML_Execute(parser_cb,compiled_2);
if (!ML_ResObj_HasAnswer(result_2))
    {
    show_message("Unexpected value for COLOR 2 at point="+string(n/checkpoints)+" , frame="+string(t));  
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
    show_message("Unexpected value for COLOR 3 at point="+string(n/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_1);
    ML_ResObj_Cleanup(result_2);
    ML_ResObj_Cleanup(result_3);
    ML_CompileCleanup(compiled_1);
    ML_CompileCleanup(compiled_2);
    ML_CompileCleanup(compiled_3);
    return 0;
    }
    
c[0] = clamp(result_1,0,255);
c[1] = clamp(result_2,0,255);
c[2] = clamp(result_3,0,255);

return 1;

