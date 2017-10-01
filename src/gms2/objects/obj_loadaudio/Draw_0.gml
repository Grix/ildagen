draw_self();

draw_set_color(c_black);
draw_set_alpha(1);
draw_set_font(fnt_tooltip);

if (seqcontrol.song == -1) 
	draw_text(x+70,y+2,"No audio");
else
{
    draw_text_ext(x+70,y+2,seqcontrol.songfile_name,1000,200);
    if (seqcontrol.parsingaudio == 1)
    {
        draw_set_color(c_maroon);
        draw_text(x+70,y+18,"Analyzing ...");
    }
}
draw_set_color(c_white);

