songinstance = 0;
if (song) FMODSoundFree(song);
songfile_loc = get_open_filename_ext("","","","Select audio file");
if !string_length(songfile_loc) 
    {
    log("cancel");
    exit;
    }
songfile = songfile_loc;
song_buffer = buffer_load(songfile_loc);
songfile_name = filename_name(songfile);
song = FMODSoundAdd(songfile_loc,0,0);
if (!song and (FMODGetLastError() == 25))
    {
    temprandomstring = string(irandom(1000000));
    buffer_save(song_buffer,"temp/tempaudio"+temprandomstring+filename_ext(songfile));
    song = FMODSoundAdd(controller.FStemp+"tempaudio"+temprandomstring+filename_ext(songfile),0,0);
    }
if (!song)
    {
    show_message_async("Failed to load audio: "+FMODErrorStr(FMODGetLastError()));
    exit;
    }
songlength = FMODSoundGetLength(song);
if (length < songlength/1000*projectfps)
    {
    length = songlength/1000*projectfps;
    endframe = length;
    }
//FMODSoundSetGroup(song, 1);

ds_list_clear(audio_list);
parseinstance = FMODSoundPlay(song,0);
FMODInstanceSetMuted(parseinstance,1);
parsingaudio = 1;
errorcheck = 0;
deltatime = 0;    
playing = 0;
tlpos = 0;

songinstance = FMODSoundPlay(song,1);

set_audio_speed();

FMODInstanceSetVolume(seqcontrol.songinstance,seqcontrol.volume/100);
