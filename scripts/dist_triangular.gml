///dist_triangular(min,mean,max,probability)
//generates a triangular distributed number

a = argument0;
b = argument2;
c = argument1;
U = argument3;

F = (c - a) / (b - a);

if (U <= F)
   return a + sqrt(U * (b - a) * (c - a));
else
   return b - sqrt((1 - U) * (b - a) * (b - c));
