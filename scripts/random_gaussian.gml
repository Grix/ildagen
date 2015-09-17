///random_gaussian(mean,standard deviation)
//generates a random number around the mean with a gaussian probability


return argument0 + argument1*sqrt(-2*ln(random(1)))*cos(random(2*pi));

/*m=argument0; s=argument1;
var x1, x2, w, y1;
y2=0;
w=2;
while ( w >= 1.0 ) 
    {
    x1 = 2.0 * random(1) - 1.0;
    x2 = 2.0 * random(1) - 1.0;
    w = x1 * x1 + x2 * x2;
    }
w = sqrt( (-2.0 * ln( w ) ) / w );
y1 = x1 * w;

return ( m + y1 * s );
