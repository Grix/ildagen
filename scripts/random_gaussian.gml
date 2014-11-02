/* gauss_random(mean,standard deviation)
* Implements the Polar form of the Box-Muller Transformation
*
* © Copyright 1994, Everett F. Carter Jr.
* Ported to GML by Tsa05
* Permission is granted by the author to use
* this software for any application provided this
* copyright notice is preserved.
*
* m = mean, s = standard deviation, return = double
* Recall that numbers beyond the Standard Deviation
* are possible (just not probable), and should be accounted for.
*
*/
m=argument0; s=argument1;
var x1, x2, w, y1;
y2=0;
use_last = 0;
w=2;
while ( w >= 1.0 ) {
x1 = 2.0 * random(1) - 1.0;
x2 = 2.0 * random(1) - 1.0;
w = x1 * x1 + x2 * x2;
}
w = sqrt( (-2.0 * ln( w ) ) / w );
y1 = x1 * w; y2 = x2 * w; use_last = 1;

return ( m + y1 * s );
