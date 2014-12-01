ML_VM_SetVarReal(parser_shape,"startx",startposx_r*128);
ML_VM_SetVarReal(parser_shape,"starty",startposy_r*128);
ML_VM_SetVarReal(parser_shape,"endx",endx_r*128);
ML_VM_SetVarReal(parser_shape,"endy",endy_r*128);
ML_VM_SetVarReal(parser_shape,"frame",t);

if (colormode == "func") or (blankmode == "func")
    {
    ML_VM_SetVarReal(parser_cb,"startx",startposx_r*128);
    ML_VM_SetVarReal(parser_cb,"starty",startposy_r*128);
    ML_VM_SetVarReal(parser_cb,"endx",endx_r*128);
    ML_VM_SetVarReal(parser_cb,"endy",endy_r*128);
    ML_VM_SetVarReal(parser_cb,"frame",t);
    ML_VM_SetVarReal(parser_cb,"pri_red",colour_get_red(color1_r));
    ML_VM_SetVarReal(parser_cb,"pri_green",colour_get_green(color1_r));
    ML_VM_SetVarReal(parser_cb,"pri_blue",colour_get_blue(color1_r));
    ML_VM_SetVarReal(parser_cb,"sec_red",colour_get_red(color2_r));
    ML_VM_SetVarReal(parser_cb,"sec_green",colour_get_green(color2_r));
    ML_VM_SetVarReal(parser_cb,"sec_blue",colour_get_blue(color2_r));
    }