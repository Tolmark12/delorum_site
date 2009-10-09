package app.view.components.swc
{

import flash.display.MovieClip;
import flash.filters.*;
import flash.events.*;
import caurina.transitions.Tweener;
import app.view.components.events.CaseStudyEvent;

public class Arrow extends MovieClip
{	
	public static const RIGHT:String 	= "right";
	public static const LEFT:String 	= "left";
	private var _direction:String;
	
	private var _arrow:Arrow_swc;
	
	public function Arrow($direction:String):void
	{		
		_direction = $direction;
		
		this.useHandCursor 	= true;
		this.buttonMode		= true;
		
		this.addEventListener( MouseEvent.CLICK, _onClick, false, 0, true );
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false, 0, true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false, 0, true );
		
		_arrow = new Arrow_swc();
		this.addChild(_arrow);
		
		if($direction == "RIGHT")
			_arrow.scaleX = -1;
	}
	
	// _____________________________ Events
	
	private function _onMouseOver ( e:Event ):void {
		_arrow.gotoAndStop(2);
	}
	
	private function _onMouseOut ( e:Event ):void {
		_arrow.gotoAndStop(1);
	}
	
	private function _onClick ( e:Event ):void {
		
		var evnt:String;
		
		switch(_direction)
		{
			case "LEFT" :
				evnt = CaseStudyEvent.PREVIOUS;
			break;
			
			case "RIGHT" :
				evnt = CaseStudyEvent.NEXT;
			break;
		}
		
		dispatchEvent( new CaseStudyEvent( evnt, true ) );
	}
}
}