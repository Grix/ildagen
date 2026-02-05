/// delayed start

load_settings();
	
parse_parameter();

window_set_size(default_window_w, default_window_h);

dacwrapper_dmx_set_rx_universe(dmx_universe);
dacwrapper_dmx_setenable(enable_artnet, enable_sacn);