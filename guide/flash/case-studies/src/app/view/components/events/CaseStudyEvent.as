package app.view.components.events
{
import flash.events.Event;

public class CaseStudyEvent extends Event
{
	// Events
	public static const CASESTUDY_CLICKED:String 	= "casestudy_clicked";
	public static const NEXT:String 				= "next";
	public static const PREVIOUS:String 			= "previous";
	
	// Data
	public var index:uint;
	
	public function CaseStudyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
	{
		super( type, bubbles, cancelable );
	}
}
}