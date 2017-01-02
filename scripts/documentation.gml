/*

TODO
-preview blindzones
-fix desync in audio analysis when switching rooms

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
                num
                name
                preset_id (-1 if default)
                preset_name
                
somaster_list
    layer elements.. (see above)

CONTROLLER

profile_list
    profiles...
        look in load_settings for all settings in map      
          
dac_list
    dac...
        num
        description
        settings map...
    
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
            ..pos 20: points
                x
                y
                blank
                c
        
    
*/
