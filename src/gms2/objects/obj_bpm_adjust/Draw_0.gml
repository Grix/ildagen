draw_self();

if (controller.use_bpm)
	draw_text(x+55,y+3,"Adjusted BPM: "+string(livecontrol.bpm_adjusted)+"/"+string(controller.bpm));
else
	draw_text(x+55,y+3,"Adjusted speed: "+string(livecontrol.speed_adjusted*100)+" %");
