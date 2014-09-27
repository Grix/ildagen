//gets the coefficients of bezier curve
//args: cp1x,cp1y,cp2x,cp2y,cp3x,cp3y,cp4x,cp4y

cx = 3 * (argument2 - argument0);
bx = 3 * (argument4 - argument2) - cx;
ax = argument6 - argument0 - cx - bx;

cy = 3 * (argument3 - argument1);
by = 3 * (argument5 - argument3) - cy;
ay = argument7 - argument1 - cy - by;

startx = argument0;
starty = argument1;
