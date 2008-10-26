package site.view.sections.portfolio_components.column_objects
{

import flash.events.*;
import flash.net.*;

public class BtnEvent extends Event
{
	public static const SHOW_CASE_STUDY:String = "SHOW_CASE_STUDY";
	
	public var xmlFileIndex:String;
	
	public function BtnEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void
	{
		super(type, bubbles, cancelable);
	}

}

}

