//toggles muted audio

if (seqcontrol.song == 0)
    exit;

seqcontrol.muted = !seqcontrol.muted;

FMODGMS_Chan_Set_Mute(play_sndchannel, seqcontrol.muted); //todo proper muting
