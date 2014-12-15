var t;
t = "
Question-In the demo, something is off with to police siren, it clips out or something
Answer-I used the same code as in the regular horn beep. The police beeps the horn to play
       the siren. That is why it stops when it's done and no other cars are in front of the 
       police car to make it beep again. I could have used a loop sound there, I know.
       
Problem-In the demo, the fps really drops when I press space to show the information
Reason-The functions to draw the spectrum and wave data use line draw and that cost a lot of stress
      -Getting data from the master group and other group takes time to analyse. You would not
       normally use those in a game.
      -I have reduced the amount of data fetched for the groups
      -However, I have increased to number of data for the instance and used the slowest
      -more accurate method to demonstrated the method so expect a drop when over an instance       

Problem-I don't get it... Why are new sounds instances cutting out old ones??? I set the stream to false. What give?
        It was not like this in Demo 1.
Reason-I have discovered an instanciating bug in FMOD that would cause the system to go unstable intanciating
        the same (unstreamed) sound many times. I have reported this problem to the FMOD developers and hard coded 
        the streamed flag to true to resolve this temporary issue. So, for the time being, multiple instances 
        of the same sound will stop the other playing sound. I hope to resolve this soon.
      -<solved>

Question-How come demo1 showed the sounds information of the cars and demo2 does not?
Answer-Because I was testing other things and had to remove the feature. However, you can
       still add a sound to a car, it will play it with information and you will not loose
       the engine sound. Kinda like having a teen playing his radio full blast, funny with the doppler on.
       
Problem-My sound volume does not seem to work propely. I set it to .1 but it's still too loud
Solution-For volumes to work right you must put the sound in a group. This bug affects 3d Sounds
        -Sometimes Master is refered to as group 0... Master in not really a group the reference
            in some function of master as group 0 is only to simplify the interface. Sounds not
            set to a group will go in the master 'virtual group' by default and that can cause
            the problem.
        -<issue solved> inform me if you still experience it.

Problem-I used Play/LoopSound or Play/LoopSound3d but the sound does not play
Solution-You created a 3d sound and tried to play it in 2d
        -You created a 2d sound and are trying to play in 3d
        -One or more of your volumes are to low sound volume, instance volume, group volume or global volume
        -You set the MinMax values improperly in you 3d sound (too small)
        -You have 3d sounds but no listener... That is FMODListenerSet3dPosition and FMODUpdatePosition
             have not been called yet.
        -Your sound is password protected and you forgot to set the password
        -<3d/2d mismatch issue solved> I added a message box to inform of the mismatch so you can resolve it faster

Problem-My 3dsounds dont seem to work. My player moves but the sounds dont play or stay at the same when I play
Solution-You forgot to add FMODListenerSet3dPosition in the player end step
        -You forgot to call FMODUpdate3dPositions once a step in a controler object
        -You did not use 3d sound
        -Your sound is password protected and you forgot to set the password
        -<3d/2d mismatch issue solved> I added a message box to inform of the mismatch so you can resolve it faster


Problem-Some of my sounds are not playing when I have a lot of objects with sounds (3d) in the room
Solution-Set the sound to a higher prority group
        -Boost the num sounds in FMODinit()
        -(*Recomended) Dont play the sound if it not close enough to the listener. You would need to
              keep track of the max value of the MinMaxDistance. EG for the demo I have.
              if(point_distance(PCarObj.x,PCarObj.y,x,y)<= _max)
              {
                   FMODSoundPlay3d(sound,x,y,0);
              }
        -Your sound is password protected and you forgot to set the password
        
Problem-My 3dsounds dont seem to work. Sounds moves with my objects but they stay the same when I play
Solution-You forgot to add FMODInstanceSet3dPosition in the object and you sound is a loop 3d sound
        -You forgot to call FMODUpdate3dPositions once a step in a controler object

Problem-My sound stops when I play it at 2 positions in the room
Solution-The sound is streamed. Read the FMODSoundAdd() comments in the script

Problem-My doppler effect it too much
Solution-Reduce the world scale FMODSetWorldScale (affects all) or set the sound's individual doppler setting 
             using FMODSoundSet3dDopplerMax

Problem-My game stops responding or I get an unxepected error when I quit the game or restart a room or restart a game
Solution-Make sure you dont free a sound that is playing or is invalid (already freed but not 0)

Problem-When I restart a room or a game the old sounds are still playing
Solution-You did not reset the system. Use the included SoundControler.

Proplem-I get an unexpected error in the game, quiting/changing room
Answer-you are freeing a sound that was freed beforehand

Problem-My game is getting slower and slower
Solution-You set the number of concurent sounds in FMODinit() too high and have too many sounds playing
        -You added a lot of sounds on the fly but never freed them
        -You have too many large sounds and you did not use the streaming option
        -Your laptop is in energy saver mode
        
Problem-My game pauses once in a while
Reason-You set the number of concurent sounds in FMODinit() too low and have too many 3d sounds playing
         so they are fighting to play.
         
Problem-I get a message about hardware acceleration...
Solution-You set the acceleration slider (In windows) to decrease performance and increase compatibility
            some people do this if they have a bad video card on older PC and XP
        -Your laptop is in power saver mode

Problem-Some functions don't work or something and I dont know why
Solution-Use show_message(FMODErrorStr(FMODGetLastError())); right after the call to see what the problem is

Question-Does your DLL leak? does not free memory?
Answer-Only if you let it, that is you dont free your sounds. Other than that, I'm pretty confident 
         I thought of everything

Question-Is it possible I can make the game crash using this dll
Answer-The only place that could happen is if you free a sound without checking
         if it's being played. It's hard to check for multiple instances of a sound
         In any case, if you stop everything when you leave a room and free the sounds
         after that, you should be fine. If you quit the game, the memory is freed
         by windows anyway. To top it off, FMOD is well implemented so it should be rare.
         One technique you can use is create your global sounds in your start game event
         like in the menu room and free them when the game quits or let windows handle it. 
         Followed by the room specific sounds when sounds used in a room are created on
         room start and stopped and freed on room end 
         Followed by the object specific sound where you can create your sound on
         room start or create (I use an alarm to make sure I dont do do it before the system
         is initialised) of an object and stop and free the sound on room end and destroy
         of the object.

Question-Why can I change the pitch of groups but not the pitch of an instance??
Answer-The feature is not included in FMOD, Use the FMODInstanceSetFrequency

Question-Why can't I get the group frequency?
Answer-The feature is not include in FMOD.
      -Use pitch. It's safer.

Question-Why does the demo goes slow when I press space to show the details
           while I have many objects visible on the screen?
Answer-In order to get the exact information on everything, I do a lot of calls
         to the dll, you would not normally do all these calls in a game
      -I also draw a lot of text and use GM drawing functions to show information
         and that causes a lot of stress on the CPU.

Question-Why dont I get doppler or realistic (stereo) sound position when I have 
          many listeners
Question-Because it would be confusing to the players to hear the other player's
          doppler or realistic position relative sound

Problem-3d sounds dont seem the pan left and right according to my settings?
Answer-You are correct. 3d sound have their pan relative to their position and listener.
       Even if you set the hear distance only, the 3d system still has a hold on the pan.
        
Problem-My password protected sound does not sound right or does not play
Cause(Not Playing)-You forgot to set the password when you loaded the sound in SoundAdd()
Cause(Not Playing)-You used the wrong password
Cause(Not Playing)-The file format use does not 'protect' properly (notify me of the format)
Cause(Weird Noises)-You set the stream option in SoundAdd on an mp3... you should not.
                   -<solved> notify me if you still have proplems with protected streamed mp3
Cause(Not Playing)-You initialised the system to play web music.

"