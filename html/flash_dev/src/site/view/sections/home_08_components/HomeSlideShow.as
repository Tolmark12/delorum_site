package site.view.sections.home_08_components
{

import flash.display.Sprite;
import gs.*;
import gs.plugins.*;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.BlurFilter;
import flash.events.*;
import delorum.utils.echo;
import delorum.utils.Sequence;

public class HomeSlideShow extends Sprite
{
	private var _slideHolder:Sprite		= new Sprite();
	private var _slideBtnHolder:Sprite 	= new Sprite();
	private var _slideList:Array  = new Array();
	private var _txt:BodyText_swc = new BodyText_swc();
	private var _sequence:Sequence;
	private var _currentBtn:SlideBtn;
	private var _currentSlide:SlideImage;
	
	public function HomeSlideShow():void
	{
		this.addChild( _slideBtnHolder );
		this.addChild( _txt );
		this.addChild( _slideHolder );
	}
	
	public function init ( $slides:Array, $css:String ):void
	{
		_txt.parseCss( $css );
		_txt.textWidth = 500;
		_txt.y = 40;
		_txt.x = 370;
		
		// Slides
		var len:uint = $slides.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			// Create Slide buttonss
			var slideBtn:SlideBtn 	= new SlideBtn(i);
			slideBtn.x = 29*i;
			slideBtn.addEventListener( MouseEvent.CLICK, _onBtnClick, false,0,true );
			_slideBtnHolder.addChild( slideBtn );
			_slideList.push( slideBtn );
			
			// Create Slides
			var slide:SlideImage 	= new SlideImage( $slides[i].img );
			slide.txt = $slides[i].htmlText;
			_slideHolder.addChild(slide);
		}
		
		_slideBtnHolder.x = 374;
		_sequence = new Sequence( _slideList );
		_currentBtn = _sequence.currentItem;
		_sequence.next();
		_currentBtn.dispatchEvent( new MouseEvent(MouseEvent.CLICK, true) );
	}
	
	// _____________________________ Event Handlers
	
	private function _onBtnClick ( e:Event ):void
	{

		var newIndex = (e.currentTarget as SlideBtn).index;
		
		if( _sequence.changeItemByIndex( newIndex ) )
		{
			if( _currentBtn != null )
				_currentBtn.deactivate();

			if( _currentSlide != null )
				_currentSlide.hide();

			_currentBtn = _sequence.currentItem;
			_currentBtn.activate();

			_currentSlide = _getSlideById( newIndex );
			_currentSlide.show();
			
			_txt.htmlText = _currentSlide.txt;
		}
	}
	
	private function _getSlideById ( $index:uint ):SlideImage
	{
		return _slideHolder.getChildAt( $index ) as SlideImage;
	}

}

}








	
