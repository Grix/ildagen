//export double FMODSpectrumSetSnapshotType(double snapshottype)
//sets the shape of the spectrum data. Affects all get spectrum data functions
//argument
//0 (default)   FMOD_DSP_FFT_WINDOW_RECT,            /* w[n] = 1.0                                                                                            */
//1             FMOD_DSP_FFT_WINDOW_TRIANGLE,        /* w[n] = TRI(2n/N)                                                                                      */
//2             FMOD_DSP_FFT_WINDOW_HAMMING,         /* w[n] = 0.54 - (0.46 * COS(n/N) )                                                                      */
//3             FMOD_DSP_FFT_WINDOW_HANNING,         /* w[n] = 0.5 *  (1.0  - COS(n/N) )                                                                      */
//4             FMOD_DSP_FFT_WINDOW_BLACKMAN,        /* w[n] = 0.42 - (0.5  * COS(n/N) ) + (0.08 * COS(2.0 * n/N) )                                           */
//5             FMOD_DSP_FFT_WINDOW_BLACKMANHARRIS,  /* w[n] = 0.35875 - (0.48829 * COS(1.0 * n/N)) + (0.14128 * COS(2.0 * n/N)) - (0.01168 * COS(3.0 * n/N)) */

return external_call(global.dll_FMODSpectrumSetSnapshotType,argument0);
