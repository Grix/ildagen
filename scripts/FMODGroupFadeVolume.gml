//FMODGroupFadeVolume(group,targetvolume,numframes)
//group 0 for all, 1-4 for a specific group
//target volume the volume to go to
//numframes. The number of frames the effect will take place
//    use room_speed*2 for 2 seconds

var d;
d = argument1
var i;
//if(argument0 = 0)
{
    i = (d-FMODGroupGetVolume(argument0))/(argument2+1);
    with(FMODFaderObj)
    {
        if(group = argument0 and isinst = false)
        {
            inc = max(abs(inc),abs(i))*sign(i);
            dest = d;
            exit
        }
    }
    with(instance_create(0,0,FMODFaderObj))
    {
        inc = i;
        dest = d;
        instvol = FMODGroupGetVolume(argument0);
        group = argument0;
        exit;
    }
}