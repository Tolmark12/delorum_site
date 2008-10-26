package site.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import flash.external.ExternalInterface;
import delorum.echo.EchoMachine;
import site.SiteFacade;
import flash.events.*;
import flash.display.*;
import flash.geom.*;
import flash.text.TextField;
import caurina.transitions.Tweener;
import site.view.sections.BaseSection;
import gs.TweenLite;
import site.model.vo.ColorScheme_VO;

public class StageMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "scroll_manager";
	
	// Browser constants
	public static const WIDE_SCREEN_WIDTH:uint 	= 950;
	public static const WIDE:String 			= "wide";
	public static const NORMAL:String 			= "normaL";
	private static var  _browserSizeState:String;
	
	// Stage
	private static var _stage:Stage;
	
	// Main sprite buckets
	private var _rootSprite:Sprite;
	private var _contentSprite:Sprite;
	private var _navSprite:Sprite;
	private var _logo:Logo_swc;
	private var _bgColorMc:Sprite;
	
	// Content
	private var _currentSection:BaseSection;

	// Browser resizing
	private static const MOVIE_WIDTH:uint = 970;
	private static const MOVIE_HEIGHT:uint = 750;
	
	// Javascript scrolling
	public var flashHeight:uint = 0;
	private static const BOTTOM_PADDIND:uint = 20;
	public var scrollBarYpos:Number = 0;
	
	// TEMP
	private var _shape:Sprite;
	
	
	public function StageMediator():void
	{
		super( NAME );
   	}

	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	SiteFacade.FLASH_HEIGHT_CHANGED,
		    		SiteFacade.BROWSER_RESIZE,
					SiteFacade.BROWSER_SCROLL,
					SiteFacade.CHANGE_COLOR_SCHEME,
					SiteFacade.PROJECT_XML_LOADED,
					SiteFacade.DEACTIVATE_PROJECT,
					SiteFacade.HIDE_CASE_STUDY,
					SiteFacade.CASE_STUDY_HIDDEN,   ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SiteFacade.DEACTIVATE_PROJECT:
				_moveBrowserScroll( 0 );
				break
			case SiteFacade.PROJECT_XML_LOADED :
//				_moveBrowserScroll( 630 );
				break;
			case SiteFacade.HIDE_CASE_STUDY:
				_moveBrowserScroll( 0, 0.7 );
				//_tweenScrollBar();
				break;
			case SiteFacade.CASE_STUDY_HIDDEN:
				//_moveBrowserScroll( 0 );
				_tweenScrollBar();
				break;
			case SiteFacade.FLASH_HEIGHT_CHANGED:
				_tweenScrollBar();
				_resizeBackgroundColor();
				break;
			case SiteFacade.BROWSER_RESIZE:
				_handleBrowserResize();
				_resizeBackgroundColor();
				break;
			case SiteFacade.BROWSER_SCROLL:
				var args:Array = note.getBody() as Array;
				_handleBrowserScroll( args[0], args[1] );
				break;
			case SiteFacade.CHANGE_COLOR_SCHEME:
				_changeColorScheme( note.getBody() as ColorScheme_VO );
				break;
		}
	}
	
	// ______________________________________________________________ Build main buckets
	
	public function build ( $mainSprite:Sprite ):void
	{
		_rootSprite			= new Sprite();			// create sprite buckets
		_contentSprite 		= new Sprite();
		_navSprite			= new Sprite();
		_logo		 		= new Logo_swc();
		_stage				= $mainSprite.stage;
		_bgColorMc			= new Sprite();
		_bgColorMc.graphics.beginFill( 0xFFFFFF );
		_bgColorMc.graphics.drawRect( 0,0,10,10 );
		_bgColorMc.y = -4000;
		
		_logo.y = _navSprite.y = 20;
		
		$mainSprite.addChild( _bgColorMc	 );		// add to display list
		$mainSprite.addChild( _rootSprite	 );
		_rootSprite.addChild( _contentSprite );		
		_rootSprite.addChild( _navSprite	 );
		_rootSprite.addChild( _logo			 );
		_handleBrowserResize();
	}
		
	// ______________________________________________________________ Browser 
	
	/**
	*	Open a connection with the javascript for handling browser 
	*	resize and changes in the flash height
	*/
	public function initBrowserConnection (  ):void
	{
		// initialize the stage for full screen amd listen for resize
		_stage.scaleMode	   = StageScaleMode.NO_SCALE;
		_stage.align 		   = StageAlign.TOP;
		_stage.addEventListener( Event.RESIZE, _resizeHandler );
		
		// Listen for javascript to let flash know scrolling occured
		if( ExternalInterface.available )
			ExternalInterface.addCallback( "scrollFlash", _scrollHandler );
	}
	
	private function _handleBrowserResize (  ):void
	{
		//EchoMachine.printErrors();
		_logo.x 			= stageLeft  + 20;
		_navSprite.x 		= stageRight - 20;
		_browserSizeState 	= ( stageWidth > WIDE_SCREEN_WIDTH )? WIDE : NORMAL ;
	}
	
	private function _resizeBackgroundColor (  ):void
	{
		_bgColorMc.x 		= stageLeft  - 20;
		_bgColorMc.y		= -20;
		_bgColorMc.width	= stageRight - stageLeft + 40;
		_bgColorMc.height 	= ( stageHeight < _rootSprite.height )? _rootSprite.height + 40 : stageHeight + 40 ;
	}
	
	private function _handleBrowserScroll ( $perc:Number, $speed:Number=0 ):void
	{
		var newY:Number;
		var speed:Number;
		if( _rootSprite.height < _stage.stageHeight ){
			newY = 0//(_stage.stageHeight - (_rootSprite.height - _rootSprite.y) ) * $perc;
		}else{
			newY = (_stage.stageHeight - _rootSprite.height - BOTTOM_PADDIND) * $perc;
		}
		
		Tweener.addTween( _rootSprite, { y: Math.round( newY ), time:$speed, transition:"EaseInOutExpo" } );
	}
	
	private function _tweenScrollBar ( $speed:Number = 0 ):void
	{                    
		Tweener.addTween( this, { flashHeight:_rootSprite.height, time:$speed, transition:"EaseInOutExpo", onUpdate:_sendFlashHeightToJS } );
	}
	
	private function _tweenBgColor ( $color, $speed:Number=0.5 ):void {
		if( $color != null ) 
			TweenLite.to(_bgColorMc, $speed, {tint:$color, onUpdate:_sendNewBgColor});
	}
	
	private function _sendFlashHeightToJS (  ):void
	{
		if( ExternalInterface.available )
			ExternalInterface.call( "setFlashHeight", flashHeight );
	}
	
	private function _moveBrowserScroll ( $distanceFromTop, $speed:Number=1 ):void
	{
		if( ExternalInterface.available )
			scrollBarYpos = ExternalInterface.call( "getScrollCordinate" );
		
//		EchoMachine.echo(ExternalInterface.call( "getScrollCordinate", flashHeight ));
		Tweener.addTween( this, { scrollBarYpos:$distanceFromTop, time:$speed, transition:"EaseInOutExpo", onUpdate:_sendScrollPositiontoJS } );
	}
	
	private function _sendScrollPositiontoJS (  ):void
	{
		//EchoMachine.echo(scrollBarYpos);
		if( ExternalInterface.available )
			ExternalInterface.call( "moveScrollToCoordinate", scrollBarYpos );
	}
	
	private function _sendNewBgColor (  ):void
	{
	   // if( ExternalInterface.available ){
	   // 	var _r:Number = _hiddenMc.transform.colorTransform.redOffset;
	   // 	var _g:Number = _hiddenMc.transform.colorTransform.greenOffset;
	   // 	var _b:Number = _hiddenMc.transform.colorTransform.blueOffset;
	   // 	ExternalInterface.call( "setBgColor", "#" + _r.toString(16) + _g.toString(16) + _b.toString(16) );
	   // }
	}
	
	// ______________________________________________________________  Modify The Color Scheme
	
	private function _changeColorScheme ( $colorScheme:ColorScheme_VO ):void
	{
		_logo.changeColors($colorScheme.logo, $colorScheme.logo_hover)
		_tweenBgColor( $colorScheme.bg )
	}
	
	// ______________________________________________________________ Managing the main content
	
	public function unloadCurrentSection (  ):void
	{
		if( _currentSection == null){
			sendNotification( SiteFacade.LOAD_NEW_SECTION )
		}else{
			_currentSection.unload();
			_currentSection = null;
		}
		
	}
	
	public function addNewSection ( $newSection:BaseSection ):void
	{
		sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED );
		_currentSection = $newSection;
		_contentSprite.addChild( _currentSection.baseMc );
	}
	
	// ______________________________________________________________ Getters / Setters
	
	// Called by control.Startup.as
	public function set defaultBg 		( $bg:uint ):void { _tweenBgColor($bg, 0) };
	
	public function get navSprite   			(  ):Sprite   { return _navSprite; };
	public function get logoSprite   			(  ):Logo_swc { return _logo; };
	public function get contentSprite  		    (  ):Sprite { return _contentSprite; };
	public static function get stageLeft   		(  ):int { return ( _stage.stageWidth  - MOVIE_WIDTH) / -2; };
	public static function get stageCenter 		(  ):int { return MOVIE_WIDTH / 2; };
	public static function get stageRight  		(  ):int { return MOVIE_WIDTH + ( _stage.stageWidth  - MOVIE_WIDTH) / 2; };
	public static function get stageBottom 		(  ):int { return /*MOVIE_HEIGHT + ( _stage.stageHeight  - MOVIE_HEIGHT) / 2;*/ _stage.stageHeight };
	public static function get stageWidth  		(  ):int { return _stage.stageWidth; };
	public static function get stageHeight  	(  ):int { return _stage.stageHeight; };
	public static function get stageMiddle 		(  ):int { return _stage.stageHeight / 2; };
	public static function get browserSizeState (  ):String { return _browserSizeState; };
	
	
	
	// ______________________________________________________________ Event Handlers
	
	private function _resizeHandler ( e:Event ):void	 { sendNotification( SiteFacade.BROWSER_RESIZE 			);	}
	private function _scrollHandler ( $perc:Number, $speed:Number ):void { sendNotification( SiteFacade.BROWSER_SCROLL, [$perc, $speed] 	); 	}
	
}
}