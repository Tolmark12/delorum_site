package site.view.sections.home_components
{

import flash.display.MovieClip;
import flash.events.*;
import caurina.transitions.Tweener;
import gs.TweenMax;
import fl.motion.easing.*;


public class MainScreen extends MovieClip
{
	private var _thumbsUp:MovieClip;
	
	public static const JUMP:String = "jump";
	
	public function MainScreen():void
	{
		_thumbsUp = this.getChildByName("thumbsUp") as MovieClip;
		_init();
	}
	
	private function _init (  ):void
	{
		_thumbsUp.addEventListener( MouseEvent.CLICK, _thumbsClick );
		_thumbsUp.addEventListener( MouseEvent.MOUSE_OVER, _thumbOver );
		_thumbsUp.addEventListener( MouseEvent.MOUSE_OUT, _thumbOut );
		_thumbsUp.buttonMode = true;
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _thumbsClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(JUMP) );
	}
	private function _thumbOver ( e:Event ):void
	{
		TweenMax.to(_thumbsUp, 0.3, {tint:0xED7920});
	}
	private function _thumbOut ( e:Event ):void
	{
		TweenMax.to(_thumbsUp, 0.3, {tint:0x000000});
	}
}

}