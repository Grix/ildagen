//export double FMODInstanceSet3DSpread(double instance, double spreadangle)
//Return 1 on success, 0 on error
//Spread angle is the angle the sound is distributed over the speakers
//This is more complicated, Quoting FMOD Documentation
/*
By default (0), if a stereo sound was played in 3d, and it was directly in front of you, 
the left and right part of the stereo sound would be summed into the center speaker 
(on a 5.1 setup), making it sound mono.
This function lets you control the speaker spread of a stereo (and above) sound within 
the speaker array, to separate the left right part of a stereo sound for example.
In the above case, in a 5.1 setup, specifying a spread of 90 degrees would put the 
left part of the sound in the front left speaker, and the right part of the sound 
in the front right speaker. This stereo separation remains intact as the listener 
rotates and the sound moves around the speakers.

To summarize (for a stereo sound).
1. A spread angle of 0 makes the stereo sound mono at the point of the 3d emitter.
2. A spread angle of 90 makes the left part of the stereo sound place itself at 45 
degrees to the left and the right part 45 degrees to the right.
3. A spread angle of 180 makes the left part of the stero sound place itself at 90 
degrees to the left and the right part 90 degrees to the right.
4. A spread angle of 360 makes the stereo sound mono at the opposite speaker location 
to where the 3d emitter should be located (by moving the left part 180 degrees left and 
the right part 180 degrees right). So in this case, behind you when the sound should be 
in front of you!

Multichannel sounds with channel counts greater than stereo have their sub-channels spread 
evently through the specified angle. For example a 6 channel sound over a 90 degree spread 
has each subchannel located 15 degrees apart from each other in the speaker array.
*/

return external_call(global.dll_FMODInstanceSet3DSpread,argument0,argument1);
