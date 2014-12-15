//FMODGroupFadePan(instance, currentpan, targetpan,numframes, updatecode)
//instance is the instance to fade
//target pan the pan to go to
//numframes. The number of frames the effect will take place
//    use room_speed*2 for 2 seconds
//Current pan is the instance's current volume to prevent
//burst of sounds. If you dont know it try 0 if fading from an unknown pan to 1 or -1
//updatecode (optional) is the code to call to update your pan variable
// it has the form of "with(100010 /*YourInstanceID*/) {YourVariableName = other.curpan;}"}
// or "global.thevariablename = curpan;"
var d;
d = argument2
var i;
//if(argument0 > 0)
{
    d = max(-1,min(d,1))+1;
    i = (d-(argument1+1))/(argument3+1);
    with(FMODPanFaderObj)
    {
        if(group = argument0 and isinst = false)
        {
            inc = max(abs(inc),abs(i))*sign(i);
            dest = d;
            exit
        }
    }
    with(instance_create(0,0,FMODPanFaderObj))
    {
        inc = i;
        dest = d;
        curpan = argument1+1;
        group = argument0;
        code = ""
        if(is_string(argument4)) code = string(argument4)
        //isinst = true;
        exit;
    }
}