//FMODInstanceFadeFrequency(instance,targetfr, time)
//instance is the sound instance, 
//targetfr, is the target frequency, 
//time is the time to do the effect for 2 seconds, use room_speed*2
//Fade the frequency

var d;
d = argument1    

var i;
//if(argument0 > 0)
{
    i = (d-FMODInstanceGetFrequency(argument0))/(argument2+1);
    with(FMODFreqFaderObj)
    {
        if(group = argument0 and isinst = true)
        {
            inc = max(abs(inc),abs(i))*sign(i);
            dest = d;
            exit
        }
    }
    with(instance_create(0,0,FMODFreqFaderObj))
    {
        inc = i;
        dest = d;
        instfreq = FMODInstanceGetFrequency(argument0);
        group = argument0;
        isinst = true;
        exit;
    }
}