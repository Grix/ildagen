function func_color() {
	if (n/checkpoints != ML_VM_GetVarReal(parser_cb,"point"))
	{
	    ML_VM_SetVarReal(parser_cb,"point",n/checkpoints);
		if (func_doaudio != 0)
		{
			ML_VM_SetVarReal(parser_cb, "audio_wave", buffer_peek(bufferIn, min(n,2047)*4, buffer_f32)/40000);
			ML_VM_SetVarReal(parser_cb, "audio_spectrum", buffer_peek(bufferOut, round(min(n/checkpoints*511,511))*4, buffer_f32));
		}
    
	    if (placing == "line")
	    {
	        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+n*vector[0]);
	        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+n*vector[1]);
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
	        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+pointx);
	        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+pointy);
	    }
	    else if (placing == "curve")
	    {
	        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+pointx);
	        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+pointy);
	    }
	    else if (placing == "free")
	    {
	        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+ds_list_find_value(free_list,2*n));
	        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+ds_list_find_value(free_list,2*n+1));
	    }
	    else if (placing == "letter")
	    {
	        ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+(ds_list_find_value(letter_list,20+4*n)-$ffff/2)*font_size/64);
	        ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+(ds_list_find_value(letter_list,20+4*n+1)-$ffff/2)*font_size/64);
	    }
	}
    
	result_1 = ML_Execute(parser_cb,compiled_1);
	if (!ML_ResObj_HasAnswer(result_1))
	{
	    show_message_new("Unexpected value for COLOR 1 at point="+string(n/checkpoints)+" , frame="+string(t));  
	    ML_ResObj_Cleanup(result_1);
	    ML_CompileCleanup(compiled_1);
	    ML_CompileCleanup(compiled_2);
	    ML_CompileCleanup(compiled_3);
		ML_ClearExceptions(parser_cb);
	    return 0;
	}
	result_2 = ML_Execute(parser_cb,compiled_2);
	if (!ML_ResObj_HasAnswer(result_2))
	{
	    show_message_new("Unexpected value for COLOR 2 at point="+string(n/checkpoints)+" , frame="+string(t));  
	    ML_ResObj_Cleanup(result_1);
	    ML_ResObj_Cleanup(result_2);
	    ML_CompileCleanup(compiled_1);
	    ML_CompileCleanup(compiled_2);
	    ML_CompileCleanup(compiled_3);
		ML_ClearExceptions(parser_cb);
	    return 0;
	}
	result_3 = ML_Execute(parser_cb,compiled_3);
	if (!ML_ResObj_HasAnswer(result_3))
	{
	    show_message_new("Unexpected value for COLOR 3 at point="+string(n/checkpoints)+" , frame="+string(t));  
	    ML_ResObj_Cleanup(result_1);
	    ML_ResObj_Cleanup(result_2);
	    ML_ResObj_Cleanup(result_3);
	    ML_CompileCleanup(compiled_1);
	    ML_CompileCleanup(compiled_2);
	    ML_CompileCleanup(compiled_3);
		ML_ClearExceptions(parser_cb);
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
	    colortemp = make_colour_rgb(clamp(answer_1,0,255),clamp(answer_2,0,255),clamp(answer_3,0,255));
	    c = colortemp;
	}
	else if (colormode2 == 1)
	{
	    colortemp = make_colour_hsv(clamp(answer_1,0,255),clamp(answer_2,0,255),clamp(answer_3,0,255));
	    c = colortemp;
	}

	return 1;



}
