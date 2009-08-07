package site.view.sections.home_08_components
{

import flash.display.Sprite;
import flash.events.*;

public class SlideBtn extends Sprite
{
	public var isSelected:Boolean = false;
	public var index:uint;
	
	public function SlideBtn( $index ):void
	{
		index = $index;
		this.buttonMode = true;
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		_make();
	}
	
	// _____________________________ APi
	
	public function activate (  ):void
	{
		_onMouseOver(null);
		this.isSelected = true;
	}
	
	public function deactivate (  ):void
	{
		this.isSelected = false;
		_onMouseOut(null);
	}
	
	
	// _____________________________ Make
	
	private function _make (  ):void
	{
		this.graphics.beginFill(0x444444, 1);
		this.graphics.drawRect( 0,0,17,17 );
		this.graphics.endFill();
		this._onMouseOut(null);
	}
	
	// _____________________________ Events
	
	private function _onMouseOver ( e:Event ):void{
		if( !this.isSelected )
			this.alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		if( !this.isSelected )
			this.alpha = 0.6;
	}
	
	private function _onClick ( e:Event ):void{
		trace( this.index );
	}
}

}