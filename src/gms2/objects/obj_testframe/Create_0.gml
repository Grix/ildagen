highlight = 0;
text="";

if (controller.preview_testframe == 0)
    testframe_usetestframe();
else if (controller.preview_testframe == 1)
    testframe_useeditor();
else if (controller.preview_testframe == 2)
    testframe_usetimeline();

