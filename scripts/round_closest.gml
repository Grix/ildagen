//changes a value arg0 from 0 to 1 to the closest exact 1/arg1 fraction

freq = argument1;
t = argument0;
closest = 1;
for (i = 0;i < freq;i++)
    {
    if (abs(t-i/freq) < closest)
        closest = i/freq;
    }
return closest;
