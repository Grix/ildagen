// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_dmx_live(){

	if (controller.enable_artnet || controller.enable_sacn)
	{
		livecontrol.masteralpha = deadband_highlow(dacwrapper_dmx_getvalue(0)) / 256;
		livecontrol.masterred = deadband_highlow(dacwrapper_dmx_getvalue(23)) / 256;
		livecontrol.mastergreen = deadband_highlow(dacwrapper_dmx_getvalue(24)) / 256;
		livecontrol.masterblue = deadband_highlow(dacwrapper_dmx_getvalue(25)) / 256;
		livecontrol.masterhue = deadband_highlow(dacwrapper_dmx_getvalue(26)) / 256;
		livecontrol.masterx = (deadband_middle(dacwrapper_dmx_getvalue(27))-128) / 128 * $8000;
		livecontrol.mastery = (deadband_middle(dacwrapper_dmx_getvalue(28))-128) / 128 * $8000;
		livecontrol.masterabsrot = deadband_middle(dacwrapper_dmx_getvalue(29)) / 256 * (pi*2);
	}

}


/*DMX channels
- 0: master intensity / blackout, 0 - 15 and 248-256 are deadbands
- 1: reserved, keep at 0 for forward compatibility
- 2: file 1: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 3: file 1 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 4: file 1 intensity / blackout,0 - 15 and 248-256 are deadbands
- 5: file 2: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 6: file 2 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 7: file 2 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 8: file 3: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 9: file 3 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 10: file 3 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 11: file 4: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 12: file 4 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 13: file 4 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 14: file 5: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 15: file 5 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 16: file 5 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 14: file 6: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 15: file 6 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 16: file 6 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 17: file 7: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 18: file 7 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 19: file 7 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 20: file 8: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 21: file 8 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 22: file 8 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 23: Master Red color intensity , 0 - 15 and 248-256 are deadbands
- 24: Master Green color intensity , 0 - 15 and 248-256 are deadbands
- 25: Master Blue color intensity , 0 - 15 and 248-256 are deadbands
- 26: Master Hue color shift, 0 - 15 and 248-256 are deadbands
- 27: Master X offset ,  124-132 is deadband
- 28: Master Y offset ,  124-132 is deadband
- 29: Master Rotation ,  124-132 is deadband
- 30: Master Speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
*/

function deadband_highlow(value)
{
	if (value < 124)
		value = value/124*128;
	else if (value > 132)
		value = 128 + (value-132)/124*128;
	else
		value = 128;
	return value;
}

function deadband_middle(value)
{
	if (value < 124)
		value = value/124*128;
	else if (value > 132)
		value = 128 + (value-132)/124*128;
	else
		value = 128;
	return value;
}