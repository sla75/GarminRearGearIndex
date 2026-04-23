import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.System;
import Toybox.WatchUi;

class SlavicsGearRearView extends WatchUi.DataField {
    private const LABELHEIGHT=0.25f as Numeric;
    private const FONTS=[
            Graphics.FONT_NUMBER_THAI_HOT,
            Graphics.FONT_NUMBER_HOT,
            Graphics.FONT_NUMBER_MEDIUM,
            Graphics.FONT_NUMBER_MILD,
            Graphics.FONT_LARGE,
            Graphics.FONT_MEDIUM,
            Graphics.FONT_SMALL,
            Graphics.FONT_TINY,
            Graphics.FONT_XTINY,
        ] as Array<Graphics.FontType>;

    private var labelArea=null as TextArea;
    private var valueArea=null as TextArea;
    private var top=0 as Number;

    function initialize() {
        DataField.initialize();
        
    }

    function onLayout(dc as Dc) as Void {
        System.println("SpeedFieldView.onLayout()");
        top=dc.getHeight()*0.025f;
        top=0;
        labelArea = new WatchUi.TextArea({
            :text=>"Label",
            :color=>Graphics.COLOR_DK_GRAY,
            :font=>FONTS.slice(4,null),
            :justification => Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER,
            :locX =>top,
            :locY=>top,
            :width=>dc.getWidth()-2*top,
            :height=>dc.getHeight()*LABELHEIGHT-top,
        });
        valueArea = new WatchUi.TextArea({
            :text=>"88.8",
            :color=>Graphics.COLOR_DK_BLUE,
            :font=>FONTS,
            :justification => Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER,
            :locX =>top,
            :locY=>dc.getHeight()*LABELHEIGHT,
            :width=>dc.getWidth()-2*top,
            :height=>dc.getHeight()*(1-LABELHEIGHT)-top
        });

    }

    function onShow() {
        System.println("SpeedFieldView.onShow()");
        
        
    }
    public function setLabel(text as String){
        labelArea.setText(text);
    }
    public function setValue(text as String or Null){
        valueArea.setText(text!=null?text:"--");
    }
    function compute(info as Activity.Info) as Void {
        System.println("SpeedFieldView.compute(info)");
        valueArea.setText((System.getClockTime().sec/3f).format("%0.1f"));
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    
    public function onUpdate(dc as Dc) as Void {
        System.println("SpeedFieldView.onUpdate()");
        dc.setColor(Graphics.COLOR_TRANSPARENT, System.getDeviceSettings().isNightModeEnabled?Graphics.COLOR_BLACK:Graphics.COLOR_WHITE);
        dc.clear();
        valueArea.draw(dc);
        labelArea.draw(dc);
        onUpdateAfter(dc);
    }
    (:release)
    private function onUpdateAfter(dc as Dc) as Void {
    }
    (:debug)
    private function onUpdateAfter(dc as Dc) as Void {
        System.println("SpeedFieldView.onUpdate()");
        dc.setColor(Graphics.COLOR_TRANSPARENT, System.getDeviceSettings().isNightModeEnabled?Graphics.COLOR_BLACK:Graphics.COLOR_WHITE);
        dc.clear();
        valueArea.draw(dc);
        labelArea.draw(dc);

        dc.setColor(Graphics.COLOR_LT_GRAY,Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(top,top,dc.getWidth()-2*top,dc.getHeight()*LABELHEIGHT-top);
        dc.drawRectangle(top,dc.getHeight()*LABELHEIGHT,dc.getWidth()-2*top,dc.getHeight()*(1-LABELHEIGHT)-top);
    }

}
