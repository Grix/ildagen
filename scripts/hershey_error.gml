if (FS_file_text_eof(hershey_file))
    {
    show_message_async("Parsing error, is this a valid hershey font file?");
    FS_file_text_close(hershey_file);
    return 0;
    }
return 1;
