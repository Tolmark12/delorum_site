package app.view.components.swc
{

import flash.display.Sprite;
import flash.filters.*;
import caurina.transitions.Tweener;

public class CaseStudyBackground extends Sprite
{
	public function CaseStudyBackground():void
	{
		_build();
	}
	
	private function _build (  ):void
	{
		// Drop Shadow
		var color:Number     = 0x000000;
		var angle:Number     = 90;
		var alpha:Number     = 0.6;
		var blurX:Number     = 7;
		var blurY:Number     = 7;
		var distance:Number  = 2;
		var strength:Number  = 0.40;
		var inner:Boolean    = false;
		var knockout:Boolean = false;
		var quality:Number   = BitmapFilterQuality.MEDIUM;

		var shadow:DropShadowFilter = new DropShadowFilter(distance,angle,color,alpha,blurX,blurY,strength,quality,inner,knockout);
		this.filters = [shadow];
	}
	
	public function resize ( $width:Number, $height:Number, $time:Number=1 ):void
	{
		Tweener.addTween( this, { width:$width, height:$height, time:$time, transition:"EaseInOutQuint"} );
	}

}
}