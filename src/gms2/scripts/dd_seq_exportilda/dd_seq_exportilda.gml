if (!verify_serial(true))
    exit;

with (seqcontrol) 
{
    export_project();
}
