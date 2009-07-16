package delorum.slides.view.components.events
{
import flash.events.Event;

public class ControlsEvent extends Event
{
	public static const RIGHT:String = "right";
	
	// EVENTS
	public static const PAUSE:String           = "pause";
	public static const SLIDE_BTN_CLICK:String = "slide_btn_click";
	public static const PLAY:String            = "play";
	public static const ARROW_CLICK:String     = "arrow_click";
	
	public var arrowClickDirection:String;
	public var clickedSlideId:Number;

	public function ControlsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
	{
		super(type, bubbles, cancelable);
	}
   
	public override function toString():String
	{
		return super.toString();
		//return ControlsEvent;
	}

}
}