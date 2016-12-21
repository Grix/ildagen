/*

TODO
-preview blindzones

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
        projector_id
        
projector_list
    projectors...
        id
        name
        preset_id (-1 if not set)
        preset_name 
        dac_list
            dacs...
                num
                name
                inverted x
                inverted y
                
somaster_list
    layer elements.. (see above)

CONTROLLER
        
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
        
            
        
settings.ini
    look in load_settings for all settings saved
    
*/
