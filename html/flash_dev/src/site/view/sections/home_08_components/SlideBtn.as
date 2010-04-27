package site.view.sections.home_08_components
{

import flash.display.*;
import flash.events.*;
import flash.text.TextField;

public class SlideBtn extends Sprite
{
	public var isSelected:Boolean = false;
	public var index:uint;
	private var _selectedMc:MovieClip;
	private var _bgMc:MovieClip;
	private var _numberTxt:TextField;
	
	public function SlideBtn(  ):void
	{
		_numberTxt = this.getChildByName( "numberTxt" ) as TextField;
		_bgMc = this.getChildByName( "bgMc" ) as MovieClip;
		_onMouseOut(null);
		this.mouseChildren = false;
	}
	
	// _____________________________ APi

	public function make ( $index ):void
	{
		index = $index;
		_numberTxt.text = $index + 1;
		_numberTxt.x = Math.round( 7 - _numberTxt.textWidth / 2 );
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
			_bgMc.alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		if( !this.isSelected )
			_bgMc.alpha = 0.55;
	}
	
	private function _onClick ( e:Event ):void{
		trace( this.index );
	}
}

}