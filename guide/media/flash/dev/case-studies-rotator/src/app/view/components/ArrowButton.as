package app.view.components
{

import flash.display.Sprite;
import flash.events.*;
import app.view.components.events.CaseStudyEvent;

public class ArrowButton extends Sprite
{
	
	public static const RIGHT:String = "right";
	public static const LEFT:String = "left";
	private var _direction:String;
	
	public function ArrowButton( $direction:String=RIGHT ):void
	{
		this.buttonMode 	= true;
		_direction 			= $direction;
		_draw( _direction == RIGHT );
		
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
	}
	
	// _____________________________ Helprs
	
	private function _draw ( $doDrawRight:Boolean ):void
	{
		// Arrow
		var wid:Number = 6;
		var tal:Number = 10;
		this.graphics.beginFill(0x77A1C6);
		this.graphics.moveTo(0,0);
		this.graphics.lineTo(wid, tal/2);
		this.graphics.lineTo(0,tal);
		this.graphics.lineTo(0,0)
		this.graphics.endFill();
		
		// Hit area
		this.graphics.beginFill(0xFF0000,0)
		this.graphics.drawRect(-10,-7,25,25)
		
		// Flip if it's the left button
		if( !$doDrawRight )
			this.scaleX = -1;
	}
	
	// _____________________________ Events
	
	private function _onMouseOut ( e:Event ):void {
		this.alpha = 1;
	}
	
	private function _onMouseOver ( e:Event ):void {
		this.alpha = 0.7;
	}
	
	private function _onClick ( e:Event ):void {
		var evnt:String = ( _direction == RIGHT )? CaseStudyEvent.NEXT : CaseStudyEvent.PREVIOUS ;
		dispatchEvent( new CaseStudyEvent( evnt, true ) );
	}
}

}