//toggles muted audio

if (!seqcontrol.song)
    exit;

seqcontrol.muted = !seqcontrol.muted;

FMODInstanceSetMuted(seqcontrol.songinstance, seqcontrol.muted);
