if (instance_exists(oDropDown))
    exit;
if (controller.sgridshow)
    {
    controller.sgridshow = 0;
    controller.rgridshow = 1;
    controller.guidelineshow = 0;
    }
else if (controller.rgridshow)
    {
    controller.sgridshow = 0;
    controller.rgridshow = 0;
    controller.guidelineshow = 1;
    } 
else if (controller.guidelineshow)
    {
    controller.sgridshow = 0;
    controller.rgridshow = 0;
    controller.guidelineshow = 0;
    } 
else
    {
    controller.sgridshow = 1;
    controller.rgridshow = 0;
    controller.guidelineshow = 0;
    } 

