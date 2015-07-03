///merge_colour_correct(c1,c2,t)
var ct1r = power(colour_get_red(argument0),2);
var ct1g = power(colour_get_green(argument0),2);
var ct1b = power(colour_get_blue(argument0),2);
var ct2r = power(colour_get_red(argument1),2);
var ct2g = power(colour_get_green(argument1),2);
var ct2b = power(colour_get_blue(argument1),2);

var ttt = argument2 mod 1;
var tttinv = 1-argument2 mod 1;

return make_colour_rgb( sqrt((ct1r*ttt+ct2r*tttinv)/2),
                        sqrt((ct1g*ttt+ct2g*tttinv)/2),
                        sqrt((ct1b*ttt+ct2b*tttinv)/2));
