package site.view.sections.home_08_components
{

import flash.display.*;
import flash.events.*;
import gs.TweenMax;

public class ThumbsBtn extends Sprite
{
	private var _thumbsUp:MovieClip;
	private var _seeOurWork:MovieClip;
	
	public function ThumbsBtn():void
	{
		_thumbsUp = this.getChildByName( "thumbsUp" ) as MovieClip;
		_seeOurWork = this.getChildByName( "seeOurWork" ) as MovieClip;
		
		this.buttonMode = true;
		this.mouseChildren = false;
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OVER, _thumbOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _thumbOut, false,0,true );
	}
	
	private function _onClick ( e:Event ):void
	{
		this.dispatchEvent( new Event("thumb_click", true) );
	}
	
	private function _thumbOver ( e:Event ):void
	{
		TweenMax.to(_thumbsUp, 0.3, {tint:0xED7920});
		TweenMax.to(_seeOurWork, 0.3, {tint:0x000000});
	}
	
	private function _thumbOut ( e:Event ):void
	{
		TweenMax.to(_thumbsUp, 0.3, {tint:0x000000});
		TweenMax.to(_seeOurWork, 0.3, {tint:0xED7920});
	}

}

}