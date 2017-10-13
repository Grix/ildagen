//toggles muted audio

if (seqcontrol.song == -1)
    exit;

seqcontrol.muted = !seqcontrol.muted;

FMODGMS_Chan_Set_Mute(seqcontrol.play_sndchannel, seqcontrol.muted);
