/// @description Insert description here
// You can write your code in this editor

if (controller.enable_artnet || controller.enable_sacn)
	draw_text(x,y, "Test monitor\nCh. 1:  " + string(dacwrapper_dmx_getvalue(0)));

