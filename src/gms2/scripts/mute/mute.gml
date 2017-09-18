//toggles muted audio

if (!seqcontrol.song)
    exit;

seqcontrol.muted = !seqcontrol.muted;

FMODGMS_Chan_Set_Volume(songinstance,0); //todo proper muting
