package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.view.sections.components.*;
import site.SiteFacade;
import site.model.vo.*;
import flash.display.Sprite;
import flash.events.*;
import caurina.transitions.Tweener;
import site.view.StageMediator;
import delorum.scrolling.*;
import site.model.ColorSchemeProxy;

public class PortfolioMediator extends BaseSection implements IMediator
{	
	protected static var NAME:String = "portfolio_section";
	public static const OUTER_PADDING:uint = 80;
	
	//State
	private static const _BROWSING:String = "ribbon";
	private static const _DETAILS:String = "details";
	private static const _FULL:String = "full";
	
	private var _stubHolder:Sprite;
	private var _scrollHolder:Sprite;
	private var _scroller:Scroller;
	private var _ribbonWidth:Number;
	private var _stubsAr:Array;
	private var _activeStub:ProjectStub;
	private var _portfolioState:String;
	
	public function PortfolioMediator():void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ SiteFacade.INIT_PORTFOLIO, 
				 SiteFacade.SHOW_STUB_OVERVIEW, 
				 SiteFacade.BROWSER_RESIZE, 
				 SiteFacade.SCROLL_PORTFOLIO, 
				 SiteFacade.PROJECT_XML_LOADING,
				 SiteFacade.PROJECT_XML_LOADED,
				 SiteFacade.CHANGE_COLOR_SCHEME,
				 SiteFacade.CUR_BTN_CLICKED_AGAIN,
				 SiteFacade.DEACTIVATE_PROJECT, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SiteFacade.INIT_PORTFOLIO:
				_portfolioState = _BROWSING;
				_createStubs( note.getBody() as Array );
				_createScrollBar();
				_resizeScrollTrack();
				_resizeScrollBar();
				_moveRibbonVertical();
				break;
			case SiteFacade.SHOW_STUB_OVERVIEW:
				_portfolioState = _DETAILS;
				_activateStub( note.getBody() as uint );
				_resizeScrollTrack();
				_updateScrollBarPosition();
				_moveRibbonVertical();
				break;
			case SiteFacade.DEACTIVATE_PROJECT :
				_portfolioState = _BROWSING;
				_deactivateActiveStub();
				_moveRibbonVertical();
				break;
			case SiteFacade.CUR_BTN_CLICKED_AGAIN:
				_handleDeactivateStub();
				break;
			case SiteFacade.BROWSER_RESIZE:
				if( _activeStub != null ) 
					_resizeActiveStub();
				else
				_displayAsRibbon();
				_resizeScrollTrack();
				_resizeScrollBar();
				_updateScrollBarPosition();
				break;
			case SiteFacade.SCROLL_PORTFOLIO :
				_scrollPortfolio( note.getBody() as ScrollEvent );
				break;
			case SiteFacade.PROJECT_XML_LOADING:
				break;
			case SiteFacade.PROJECT_XML_LOADED:
				_portfolioState = _FULL;
				_activeStub.buildPage( note.getBody() as Page_VO );
				_moveRibbonVertical();
				_displayAsRibbon();
				break;
		}
	}
	
	// ______________________________________________________________ Make
	
	private function _createStubs ( $stubAr:Array ):void
	{
		ProjectStub.currentProject = null;
		super._baseMc.y = StageMediator.stageMiddle - ProjectStub.HEIGHT / 2;

		_scrollHolder 	= new Sprite();
		_stubHolder 	= new Sprite();
		_stubsAr		= new Array();
		_stubHolder.x = StageMediator.stageLeft + OUTER_PADDING;
		super._baseMc.addChild( _scrollHolder );
		super._baseMc.addChild( _stubHolder );
		
		var len:uint = $stubAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stub_vo:ProjectStub_VO  = $stubAr[i];
			var stub:ProjectStub		= new ProjectStub();
			stub.make( stub_vo );
			stub.addEventListener( ProjectStub.ACTIVATE_STUB, _handleActivateStub );
			stub.addEventListener( ProjectStub.DE_ACTIVATE_STUB, _handleDeactivateStub );
			stub.addEventListener( ProjectDetails.LOAD_PROJECT_XML, _handleStubXmlRequest );
			stub.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleHeigthChange);
			_stubHolder.addChild( stub );
			_stubsAr.push( stub );
		}
		super.show();
		_displayAsRibbon();
	}
	
	private function _createScrollBar (  ):void
	{
		var colorScheme:ColorScheme_VO 	= ColorSchemeProxy.currentColorScheme;
		_scrollHolder.x = OUTER_PADDING;
		_scrollHolder.y = 265;
		
		_scroller = new Scroller( _scrollHolder, 800, Scroller.HORIZONTAL, colorScheme.scrollbar_bar, colorScheme.scrollbar_track, colorScheme.scrollbar_track_border );
		_scroller.addEventListener( Scroller.SCROLL, _handleScroll );
	}
	
	// ______________________________________________________________ Vertical positioning
	
	private function _moveRibbonVertical (  ):void
	{
		var yTarget:uint;
		
		switch (_portfolioState ){
			case _BROWSING :
				yTarget = StageMediator.stageMiddle - ProjectStub.HEIGHT / 2;
				break;
			case _DETAILS :
				yTarget = 110;
				break;
			case _FULL :
				yTarget = 80;
				break;
		}
		
		// Temp disableing moving
		yTarget = 110;
		Tweener.addTween( super._baseMc, { y:yTarget, time:1, transition:"EaseInOutQuint"} );
	}
	
	// ______________________________________________________________ Stub display
	
	private function _displayAsRibbon (  ):void
	{
		_ribbonWidth = 0;
		var len:uint = _stubsAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stub:ProjectStub = _stubsAr[i];
			// Make stub small if it's not the activestub
			if( stub != _activeStub && _activeStub != null) {
				if( _portfolioState == _FULL ) {
					stub.setState( ProjectStub.TINY );
				}else{
					stub.setState( ProjectStub.SMALL );
				}
				stub.dimImage();
				
			}
			
			if( _portfolioState == _BROWSING || stub == _activeStub) 
				stub.brightenImage();
			else
				stub.dimImage();
			
			// Move to new position
			stub.moveTo( _ribbonWidth, 0 );
			_ribbonWidth += stub.stubWidth;
		}
		
		var newx:Number = ( _activeStub != null ) ? StageMediator.stageLeft - _activeStub.targetX + OUTER_PADDING
		 										  : StageMediator.stageLeft + OUTER_PADDING;
		
		Tweener.addTween( _stubHolder, { x:newx, time:1, transition:"EaseInOutQuint"} );
	}
	
	private function _activateStub ( $id:uint ):void
	{
		_activeStub = _stubsAr[ $id ];
		_resizeActiveStub();
	}
	
	private function _deactivateActiveStub (  ):void
	{
		if( _activeStub != null ) {
			_activeStub.setState( ProjectStub.SMALL );
			// Center ribbon on stub 2 places to the left
			_activeStub = (_activeStub.arrayIndex - 2 < 0)? _stubsAr[0] : _stubsAr[_activeStub.arrayIndex - 2] ; 
			_displayAsRibbon();
			_resizeScrollBar();
			_updateScrollBarPosition();
			ProjectStub.currentProject = null;
			_activeStub = null;
		}
	}
	
	private function _resizeActiveStub (  ):void
	{
		var stubWidth:String = ( StageMediator.browserSizeState == StageMediator.WIDE )? ProjectStub.LARGE : ProjectStub.MEDIUM;
		_activeStub.setState( stubWidth );
		_displayAsRibbon();
		Tweener.addTween( this, { time:0.2, onComplete:_activeStub.bringToFront } );
	}
	
	// ______________________________________________________________ Scrolling
	
	private function _scrollPortfolio ( e:ScrollEvent ):void
	{
		var x:Number;
		// Right edge is right or browser window
		if( _activeStub == null ) {
			x = (StageMediator.stageLeft + OUTER_PADDING) - (_ribbonWidth - (StageMediator.stageRight - StageMediator.stageLeft - OUTER_PADDING * 2) ) * e.percent;
		}else{
			x = (StageMediator.stageLeft + OUTER_PADDING) - (_ribbonWidth - _activeStub.stubWidth ) * e.percent;
		}
		
		if( e.easeMotion ) 
			Tweener.addTween( _stubHolder, { x:x, time:0.5} );
		else
			_stubHolder.x = x;
	}
	
	private function _resizeScrollBar (  ):void
	{
		_scroller.updateScrollWindow( StageMediator.stageWidth / _ribbonWidth );
	}
	
	private function _resizeScrollTrack (  ):void
	{
		Tweener.addTween( _scrollHolder, { x:StageMediator.stageLeft + OUTER_PADDING - 12, time:1, transition:"EaseInOutQuint"} );
		_scroller.changeWidth( StageMediator.stageWidth - OUTER_PADDING * 2 );
	}
	
	private function _updateScrollBarPosition (  ):void
	{
		if( _activeStub != null ) 
			_scroller.changeScrollPosition( _activeStub.arrayIndex / (_stubsAr.length - 1));
			
	}
	
	
	// ______________________________________________________________ Event Handlers
	
	// Project stub
	public function _handleActivateStub   ( e:Event 	   ):void { sendNotification( SiteFacade.PROJECT_STUB_CLICK, e.target.arrayIndex );  };
	public function _handleDeactivateStub ( e:Event = null ):void { sendNotification( SiteFacade.DEACTIVATE_STUB_CLICK	); };
	public function _handleStubXmlRequest ( e:Event 	   ):void { sendNotification( SiteFacade.LOAD_PROJECT_XML 		); };
	public function _handleHeigthChange   ( e:Event 	   ):void { sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED 	); };
	// Scrolling
	public function _handleScroll    ( e:ScrollEvent ):void{ sendNotification( SiteFacade.SCROLL_PORTFOLIO, e ); };
	
}
}