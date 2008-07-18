package swc_components
{

import DelorumSite;
import flash.display.*;
import flash.events.*;
import gs.TweenLite;


public class Logo_swc extends MovieClip
{
	public function Logo_swc():void
	{
		this.buttonMode = true;
		_drawHitArea();
		this.addEventListener( MouseEvent.MOUSE_OVER, _rollOver );
		this.addEventListener( MouseEvent.MOUSE_OUT,  _rollOut );
	}

	// ______________________________________________________________ Build
	
	private function _drawHitArea (  ):void
	{
		var hitArea:Sprite  = new Sprite();
		var xtra:uint		= 20; 
		hitArea.graphics.beginFill(0xFF0000);
		hitArea.graphics.drawRect(0,0,this.width + xtra, this.height + xtra);
		hitArea.x = xtra / -2;
		hitArea.y = xtra / -2;
		hitArea.alpha = 0;
		this.addChild( hitArea );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _rollOver ( e:Event ):void
	{
		// Matt Gessel  -  jgessel@coe.usu.edu
		TweenLite.to(this, 0.2, { tint:DelorumSite.TAN });
	}
	
	private function _rollOut ( e:Event ):void
	{
		TweenLite.to(this, 0.2, { tint:DelorumSite.GRAY_MED });
	}
}

}
