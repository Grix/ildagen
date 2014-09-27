//gets x pos in bezier curve
//args: t,starty

t = argument0;

return ((ay*t*t*t)+(by*t*t)+(cy*t)+starty);
