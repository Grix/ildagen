//FMODGroupFadePitch(group,targetfreq,numframes)
//group 0 for all, 1-4 for a specific group
//target Frequency the Frequency to go to
//numframes. The number of frames the effect will take place
//    use room_speed*2 for 2 seconds

var d;
d = argument1
var i;
if(argument0 >= 0 and argument0 <=4)
{
    i = (d-FMODGroupGetPitch(argument0 ))/(argument2+1);
    with(FMODPitchFaderObj)
    {
        if(group = argument0 and isinst = false)
        {
            inc = max(abs(inc),abs(i))*sign(i);
            dest = d;
            exit
        }
    }
    with(instance_create(0,0,FMODPitchFaderObj))
    {
        inc = i;
        dest = d;
        instpitch = FMODGroupGetPitch(argument0 )
        group = argument0;
        exit;
    }
}