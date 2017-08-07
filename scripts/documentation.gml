/*

TODO
-preview blindzones

SETTINGSCONTROL



SEQCONTROL

layer_list
    layers...
        envelope_list
            envelopes...
                type
                env_time_list
                env_data_list
                disabled
                hidden
        element_list
            layer elements...
                xpos on timeline
                frame buffers
                info list..
                    length
                    screenshot surface
                    maxframes
        muted
        hidden
        name
        dac_list
            dacs...
                num (index in dac_list)
                name
                profile name
                
somaster_list
    layer elements.. (see above)

CONTROLLER

profile_list
    profiles... (default is controller.projector - index)
        look in load_settings for all settings in map      
          
dac_list
    dac... (default is controller.dac - not index, list itself)
        num (index in dacwrapper)
        name
        profile num (-1 if default)
        firmware (-1 if n/a)
        output_buffer
        output_buffer2
        output_buffer_ready
        output_buffer_next_size
    
blindzone_list
    start x
    end x
    start y
    end y
    ..x4 for each
        
frame_list
    frame...
        el_list
            origo_x
            origo_y
            end_x
            end_y
            xmin
            xmax
            ymin
            ymax
            ..pos 9: el_id
            is_blindzone
            force_pol0
            ..pos 20: points:
            x
            y
            blank
            c
            x4 for each
        
    
*/
