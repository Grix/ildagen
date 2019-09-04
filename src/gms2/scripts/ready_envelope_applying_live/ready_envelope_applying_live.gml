// readies global modifier (which uses code for envelopes from seq mode)

env_xtrans = (masterx != 0);
env_xtrans_val = clamp(masterx, -$8000, $8000);
env_ytrans = (mastery != 0);
env_ytrans_val = clamp(mastery, -$8000, $8000);
env_size = 0;
env_rotabs = (masterabsrot != pi);
env_rotabs_val = clamp(masterabsrot, 0, pi*2);
env_a = (masteralpha != 1);
env_a_val = 1-clamp(masteralpha, 0, 1);
env_hue = (masterhue != 1);
env_hue_val = clamp(masterhue, 0, 255);
env_r = (masterred != 1);
env_r_val = clamp(masterred, 0, 1);
env_g = (mastergreen != 1);
env_g_val = clamp(mastergreen, 0, 1);
env_b = (masterblue != 1);
env_b_val = clamp(masterblue, 0, 1);
