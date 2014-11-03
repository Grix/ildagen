//random_triangular(min,mean,max)
//generates a random number with a triangular probability

a = argument0;
b = argument2;
c = argument1;
U = random(1);

F = (c - a) / (b - a);

if (U <= F)
   return a + sqrt(U * (b - a) * (c - a));
else
   return b - sqrt((1 - U) * (b - a) * (b - c));
