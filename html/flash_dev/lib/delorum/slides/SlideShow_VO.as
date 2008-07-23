package delorum.slides
{

import flash.display.Sprite;

public class SlideShow_VO extends Sprite
{
	public var slides:Array;
	
	/** 
	*	Constructor, creates a new slideshow value object.
	*	
	*	@param		An xml list full of img tags ex: <img src="my_image.jpg" /> etc...
	*	@param		The directory where the images live
	*/
	public function SlideShow_VO ( $slideShowXml:XMLList, $imagePath:String="" ):void
	{
		slides = new Array();
		var count:uint = 0;
		
		for each( var node:XML in $slideShowXml.img)
		{
			var vo 			= new Slide_VO(  );
			vo.imagePath 	= $imagePath + node.@src;
			vo.id			= "slide" + count++;
			slides.push( vo );
		}
	}

}
}
