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
import flash.filters.*;
import flash.net.navigateToURL;
import flash.net.URLRequest;

public class HomeSlideShow extends Sprite
{
	private var _slideHolder:Sprite		= new Sprite();
	private var _slideBtnHolder:Sprite 	= new Sprite();
	private var _slideList:Array  = new Array();
	private var _txt:BodyText_swc = new BodyText_swc();
	private var _sequence:Sequence;
	private var _currentBtn:SlideBtn;
	private var _currentSlide:SlideImage;
	private var _buttons:Buttons = new Buttons();;
	
	public function HomeSlideShow():void
	{
		this.addChild( _slideBtnHolder );
		this.addChild( _txt );
		this.addChild( _buttons );
		this.addChild( _slideHolder );
	}
	
	public function init ( $slides:Array, $css:String ):void
	{
		_txt.parseCss( $css );
		_txt.textWidth = 500;
		_txt.y = 40;
		_txt.x = 370;
		
		_buttons.x = 370;
		
		// Slides
		var len:uint = $slides.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			// Create Slide buttonss
			var slideBtn:SlideBtn 	= new SlideBtn_swc();
			slideBtn.make(i);
			slideBtn.x = 22*i;
			slideBtn.addEventListener( MouseEvent.CLICK, _onBtnClick, false,0,true );
			_slideBtnHolder.addChild( slideBtn );
			_slideList.push( slideBtn );
			
			// Create Slides
			var slide:SlideImage 	= new SlideImage( $slides[i].img );
			slide.txt = $slides[i].htmlText;
			slide.href = $slides[i].href;
			slide.buttons = $slides[i].buttons;
			slide.addEventListener( MouseEvent.CLICK, _onSlideImageClick, false,0,true );
			_slideHolder.addChild(slide);
		}
		
		_addButtonDropShadow();
		
		_slideBtnHolder.y = -3;
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
			_buttons.removeButtons();
			_buttons.addButtons(_currentSlide.buttons)
			_buttons.y = _txt.y + _txt.height + 20;
		}
	}
	
	private function _onSlideImageClick ( e:Event ):void
	{
		var slide:SlideImage = e.currentTarget as SlideImage;
		navigateToURL(new URLRequest(slide.href), '_self');
	}
	
	private function _getSlideById ( $index:uint ):SlideImage
	{
		return _slideHolder.getChildAt( $index ) as SlideImage;
	}
	
	private function _addButtonDropShadow (  ):void
	{
		var color:Number = 0x000000;
		var angle:Number = 90;
		var alpha:Number = 0.5;
		var blurX:Number = 3;
		var blurY:Number = 3;
		var distance:Number = 1;
		var strength:Number = 0.40;
		var inner:Boolean = false;
		var knockout:Boolean = false;
		var quality:Number = BitmapFilterQuality.LOW;
		var dsf:DropShadowFilter = new DropShadowFilter(distance,angle,color,alpha,blurX,blurY,strength,quality,inner,knockout);
		_slideBtnHolder.filters = [dsf]
	}

}

}