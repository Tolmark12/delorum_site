package app.view.components
{

import app.view.components.events.CaseStudyEvent;
import flash.display.Sprite;
import flash.events.*;

public class NumberButton extends Sprite
{
	private var _index:Number;
	private var _isActive:Boolean = false;
	
	public function NumberButton( $index:Number ):void {
		super();
		
		_index = $index;
		this.buttonMode = true;
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		_build();
	}
	
	// _____________________________ API
	
	public function activate (  ):void
	{
		_onMouseOver(null);
		_isActive = true;
	}
	
	public function deactivate (  ):void
	{
		_isActive = false;
		_onMouseOut(null);
	}
	
	// _____________________________ Build
	
	private function _build (  ):void
	{
		// Number
		var numberTxt:NumberTxt_swc 	= new NumberTxt_swc();
		numberTxt.titleTxt.text 		= String( _index + 1 );
		numberTxt.titleTxt.selectable 	= false;
		this.mouseChildren 				= false;
		this.addChild( numberTxt );
		
		// Draw hit area
		var size:Number 				= 10;
		this.graphics.beginFill(0xFF0000,0);
		this.graphics.drawRect(size/-2,size/-2 +5,size*2,size*2);
	}
	
	// _____________________________ Events
	
	private function _onMouseOver ( e:Event ):void {
		if( !_isActive )
			this.alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		if( !_isActive )
			this.alpha = 0.5;
	}
	
	private function _onClick ( e:Event ):void {
		var caseStudyEvent:CaseStudyEvent = new CaseStudyEvent( CaseStudyEvent.CASESTUDY_CLICKED, true );
		caseStudyEvent.index = _index;
		dispatchEvent( caseStudyEvent );
	}
	
}

}