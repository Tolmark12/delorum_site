package swc_components
{

import flash.display.MovieClip;

public class CircleBtn_swc extends MovieClip
{
	public static const DOWN_ARROW:String 	= "down_arrow";
	public static const HIT_PADDING:uint 	= 5;
	
	public function CircleBtn_swc(  ):void{
		this.buttonMode = true;
	}
	
	// ______________________________________________________________ Make
	public function make ( $text:String=null, $symbol:String=null ):void
	{
		this.graphics.beginFill(0x000000, 0);
		this.graphics.drawRect( -HIT_PADDING, -HIT_PADDING, this.width + HIT_PADDING*2, this.height + HIT_PADDING*2 )
	}

}

}