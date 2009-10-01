package site.view.sections.home_08_components
{

import flash.display.*;
import flash.events.*;

public class SlideBtn extends Sprite
{
	public var isSelected:Boolean = false;
	public var index:uint;
	private var _selectedMc:MovieClip;
	
	public function SlideBtn(  ):void
	{
	}
	
	// _____________________________ APi

	public function make ( $index ):void
	{
		index = $index;
		this.buttonMode = true;
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		_selectedMc = this.getChildByName( "selectedMc" ) as MovieClip;
		_selectedMc.visible = false;
	}

	
	public function activate (  ):void
	{
		_onMouseOver(null);
		_selectedMc.visible = true;
		this.isSelected = true;
	}
	
	public function deactivate (  ):void
	{
		this.isSelected = false;
		_selectedMc.visible = false;
		_onMouseOut(null);
	}
	

	// _____________________________ Events
	
	private function _onMouseOver ( e:Event ):void{
		if( !this.isSelected )
			this.alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		if( !this.isSelected )
			this.alpha = 0.85;
	}
	
	private function _onClick ( e:Event ):void{
		trace( this.index );
	}
}

}