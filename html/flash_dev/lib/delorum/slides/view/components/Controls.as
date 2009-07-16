package delorum.slides.view.components
{

import flash.display.Sprite;
import delorum.slides.view.components.events.ControlsEvent;
import flash.events.*;
import delorum.slides.SlideShowFacade;
import delorum.slides.Slide_VO;
import caurina.transitions.Tweener;

public class Controls extends Sprite
{
	public static const BOTTOM:Number  = 370;
	public static const WIDTH:Number   = 508;
	
	private var _btnsAr:Array;
	private var _currentBtn:ThumbnailBtn;
	private var _playPauseBtn:PlayPauseBtn;
	private var _baseX:Number;
	private var _rightBtn:ArrowBtn;
	private var _leftBtn:ArrowBtn;
	private var _hitSprite:Sprite = new Sprite()
	private var _holder:Sprite = new Sprite();
	
	public function Controls():void
	{
		
	}
	
	public function createControls ( $slides:Array ):void
	{
		this.addChild(_holder);
		_btnsAr = new Array();
		var xInc:uint = 15;
		
		var wid:Number = SlideShowFacade.slidesWidth;
		_holder.x = wid ; 
		var len:uint  = $slides.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var slideVo:Slide_VO = $slides[i];
			var btn:ThumbnailBtn = new ThumbnailBtn(slideVo);
			
			btn.build(3);
			btn.unHighlight();
			btn.addEventListener( MouseEvent.CLICK, _onSlideBtnClick, false,0,true );
			btn.x = xInc * i;
			_btnsAr[slideVo.index] = btn;
			
			_holder.x -= xInc;
			_holder.addChild(btn);
		}
		
		_baseX = _holder.x;
		
		// Create play and pause button
		_playPauseBtn = new PlayPauseBtn();
		_playPauseBtn.addEventListener( PlayPauseBtn.PAUSE, _onPause );
		_playPauseBtn.addEventListener( PlayPauseBtn.PLAY,  _onPlay  );
		_playPauseBtn.x = _holder.width  + 20;
		
		// Create previous and next buttons
		_rightBtn 		= new ArrowBtn( ArrowBtn.RIGHT );
		_leftBtn 		= new ArrowBtn( ArrowBtn.LEFT  );
		_rightBtn.mouseOutColor = 0xBBBBBB;
		_leftBtn.mouseOutColor = 0xBBBBBB;
		_rightBtn.dispatchEvent( new MouseEvent(MouseEvent.MOUSE_OUT, true) );
		_leftBtn.dispatchEvent( new MouseEvent(MouseEvent.MOUSE_OUT, true) );
		_rightBtn.x 	= _holder.width + 10;
		_leftBtn.x  	= -20;
		_leftBtn.scaleX = 0;
		_rightBtn.addEventListener( MouseEvent.CLICK, _onArrowBtnClick, false,0,true );
		_leftBtn.addEventListener ( MouseEvent.CLICK, _onArrowBtnClick, false,0,true );

		//this.addChild( _playPauseBtn );
		_holder.addChild( _rightBtn	);
		_holder.addChild( _leftBtn		);
		
		// Hit area for next / previous buttons
		_hitSprite.graphics.beginFill(0xFF0000, 0);
		_hitSprite.useHandCursor = true;
		_hitSprite.graphics.drawRect(0,0,WIDTH,BOTTOM);
		_hitSprite.addEventListener( MouseEvent.MOUSE_OVER, _onHitMouseOver, false,0,true );
		_hitSprite.addEventListener( MouseEvent.MOUSE_OUT,  _onHitMouseOut, false,0,true );
		_hitSprite.x = wid - WIDTH;
		this.addChildAt(_hitSprite,0);
	}
	
	public function activateBtn ( $index:uint ):void
	{
		if( _currentBtn != null )
			_currentBtn.unHighlight();
		_currentBtn = _btnsAr[ $index ] as ThumbnailBtn;
		_currentBtn.highlight();
	}
	
	public function startAutoPlay (  ):void
	{
		_playPauseBtn.changeState( PlayPauseBtn.PAUSE );
	}
	
	public function stopAutoPlay (  ):void
	{
		_playPauseBtn.changeState( PlayPauseBtn.PLAY  );
	}
	
	private function _showControls (  ):void
	{
		trace( "show" );
		Tweener.removeTweens( _leftBtn, scaleX );
		Tweener.removeTweens( _holder, x );
		Tweener.addTween( _leftBtn, { scaleX:1, time:0.8, transition:"EaseInOutQuint"} );
		Tweener.addTween( _holder, { x:_baseX - 20, time:0.8, transition:"EaseInOutQuint"} );
	}
	
	private function _hideControls (  ):void
	{
		trace( "hide" );
		Tweener.removeTweens( _leftBtn, scaleX );
		Tweener.removeTweens( _holder, x );
		Tweener.addTween( _leftBtn, { scaleX:0, time:0.6, transition:"EaseInOutQuint", delay:0.7} );
		Tweener.addTween( _holder, { x:_baseX, time:0.6, transition:"EaseInOutQuint",  delay:0.7} );
	}
	
	// _____________________________ Event Handlers
	
	private function _onHitMouseOut ( e:Event ):void {
		if( this.mouseX > SlideShowFacade.slidesWidth || this.mouseX < _hitSprite.x ||  this.mouseY > this.height-10 || this.mouseY < 0 ){
			_hideControls()
			_hitSprite.addEventListener( MouseEvent.MOUSE_OVER, _onHitMouseOver, false,0,true );
		}
	}
	
	private function _onHitMouseOver ( e:Event ):void {
		_showControls()
		_hitSprite.removeEventListener( MouseEvent.MOUSE_OVER, _onHitMouseOver );
	}
	
	private function _onArrowBtnClick ( e:Event ):void {
		var ev:ControlsEvent = new ControlsEvent( ControlsEvent.ARROW_CLICK, true );
		ev.arrowClickDirection = e.currentTarget.direction;
		dispatchEvent( ev );
	}
	
	private function _onPause ( e:Event ):void {
		dispatchEvent( new ControlsEvent( ControlsEvent.PAUSE, true ) );
	}
	
	private function _onPlay ( e:Event ):void {
		dispatchEvent( new ControlsEvent( ControlsEvent.PLAY, true ) );
	}
	
	private function _onSlideBtnClick ( e:Event ):void {
		var ev:ControlsEvent = new ControlsEvent( ControlsEvent.SLIDE_BTN_CLICK, true );
		ev.clickedSlideId = e.currentTarget.slideIndex;
		dispatchEvent( ev );
	}
	
	

}

}