// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ease_in_out(t)
{
	gml_pragma("forceinline");
	if (t < 0.5)
		return 2 * t*t;
	else
		return 1 - power(-2 * t+2, 2) / 2;
}