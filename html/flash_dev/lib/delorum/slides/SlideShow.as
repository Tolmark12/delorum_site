package delorum.slides
{

import flash.display.Sprite;
import flash.events.*;

public class SlideShow extends Sprite
{
	private var _facade:SlideShowFacade;
	private static var _showCount:uint = 0;
	
	public function SlideShow():void
	{
		this.addEventListener( Event.REMOVED_FROM_STAGE, _unmake );
		_facade = SlideShowFacade.getInstance( "slideShow"  );
	}
	
	
	// ______________________________________________________________ Removing
	
	public function _unmake ( e:Event ):void
	{
		_facade.unmake();
	}
	
	// ______________________________________________________________ API
	
	/** 
	*	Build the slideshow based on an array of images paths
	*	
	*	@param		Value object with data for slide show
	*/
	public function buildSlideShow ( slideShowArray:SlideShow_VO ):void{
		_facade.startup( this );
		_facade.buildSlideShow( slideShowArray );
	}

}

}