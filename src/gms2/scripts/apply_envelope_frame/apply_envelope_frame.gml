gml_pragma("forceinline");

///apply_envelope_frame(scale factor)
//apply envelope transforms to frame data
if (env_xtrans)
{
    xo += env_xtrans_val*argument0;
}
if (env_ytrans)
{
    yo += env_ytrans_val*argument0;
}
