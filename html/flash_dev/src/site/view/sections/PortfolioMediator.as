package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.view.sections.portfolio_components.*;
import site.SiteFacade;
import site.model.vo.*;
import flash.display.Sprite;
import flash.events.*;
import caurina.transitions.Tweener;
import site.view.StageMediator;
import delorum.scrolling.*;
import site.model.ColorSchemeProxy;
import site.model.CssProxy;
import site.view.sections.portfolio_components.column_objects.BtnEvent;
import delorum.utils.echo;
import flash.filters.*;

public class PortfolioMediator extends BaseSection implements IMediator
{	
	protected static var NAME:String = "portfolio_section";
	public static const OUTER_PADDING:uint = 80;
	
	//State
	private static const _BROWSING:String = "ribbon";
	private static const _DETAILS:String = "details";
	private static const _FULL:String = "full";
	
	// Positioning
	public static const SCROLL_Y_BROWSING:Number = 295;
	public static const SCROLL_Y_OPEN:Number = 390;
	public static const RIBBON_Y_BROWSING:Number = 0;
	public static const RIBBON_Y_OPEN:Number = 30;
	
	// Display
	private var _stubHolder:Sprite;
	private var _scrollHolder:Sprite;
	private var _scroller:Scroller;
	private var _holder:Sprite;
	private var _details:ProjectDetails;

	private var _ribbonWidth:Number;
	private var _stubsAr:Array;
	private var _activeStub:ProjectStub;
	private var _portfolioState:String;
	private var _realativeXpos:Number;
	
	private var _alternateXml:String;
	
	private var _caseStudyIsVisible:Boolean = false;
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
				 SiteFacade.DEACTIVATE_PROJECT,
				 SiteFacade.HIDE_CASE_STUDY,
				 SiteFacade.SHOW_CASE_STUDY,
				 SiteFacade.PFLIO_SCROLL_RELEASE,
				 SiteFacade.PFLIO_SCROLL_PRESS, ]
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
				_hideDetails();
				_portfolioState = _DETAILS;
				_activateStub( note.getBody() as uint );
				_resizeScrollTrack();
				_updateScrollBarPosition();
				_resizeScrollBar(1);
				_moveRibbonVertical();
				ProjectStub.isInBrowsingMode = false;
				break;
			case SiteFacade.DEACTIVATE_PROJECT :
				_portfolioState = _BROWSING;
				_deactivateActiveStub();
				_moveRibbonVertical();
				if( _scroller != null )
					_scroller.changeScrollPosition(0);
				var e:ScrollEvent  = new ScrollEvent( "FAKE_event" );
				e.percent = 0;
				e.easeMotion = true
				_scrollPortfolio( e );
				break;
			case SiteFacade.SHOW_CASE_STUDY : 
				if( !_caseStudyIsVisible ) {
					_alternateXml = note.getBody() as String;
					_caseStudyIsVisible = true;
					_changeDetails ( _activeStub.vo );
					_details.show();
				}
				break;
			case SiteFacade.HIDE_CASE_STUDY :
				if( _details != null && _caseStudyIsVisible) {
					_caseStudyIsVisible = false;
					_details.closePage();
				}
				break;
			case SiteFacade.CUR_BTN_CLICKED_AGAIN:
				_handleDeactivateStub();
				ProjectStub.isInBrowsingMode = true;
				break;
			case SiteFacade.BROWSER_RESIZE:
				if( _activeStub != null ) {
					_resizeActiveStub();
				}
				_alignRibbonLeft();
				_moveDetails();
				_resizeScrollTrack(0);
				_resizeScrollBar(0);
				if( _scroller != null )
					_updateScrollBarPosition( _scroller.scrollPosition );
				break;
			case SiteFacade.SCROLL_PORTFOLIO :
				_scrollPortfolio( note.getBody() as ScrollEvent );
				break;
			case SiteFacade.PROJECT_XML_LOADING:
				break;
			case SiteFacade.PROJECT_XML_LOADED:
				_portfolioState = _FULL;
				_details.buildPage( note.getBody() as Page_VO );
				//_displayAsRibbon();
				break;
			case SiteFacade.PFLIO_SCROLL_PRESS :
				_brightenOrDimStubs(true);
				ProjectStub.isInBrowsingMode = true;
				break;
			case SiteFacade.PFLIO_SCROLL_RELEASE :
				_brightenOrDimStubs(false);
				break;
		}
	}
	
	// ______________________________________________________________ Make
	
	private function _createStubs ( $stubAr:Array ):void
	{
		ProjectStub.currentProject = null;
		super._baseMc.y = 95;
		
		// Create display items
		_scrollHolder 	= new Sprite();
		_stubHolder 	= new Sprite();
		_details 		= new ProjectDetails();		
		_stubsAr		= new Array();
		
		var color:Number = 0x000000;
		var angle:Number = 90;
		var alpha:Number = 0.6;
		var blurX:Number = 10;
		var blurY:Number = 10;
		var distance:Number = 7;
		var strength:Number = 0.40;
		var inner:Boolean = false;
		var knockout:Boolean = false;
		var quality:Number = BitmapFilterQuality.LOW;
		var dsf:DropShadowFilter = new DropShadowFilter(distance,angle,color,alpha,blurX,blurY,strength,quality,inner,knockout);
		_stubHolder.filters = [ dsf ];
		
		_details.addEventListener( ProjectStub.DE_ACTIVATE_STUB, _handleDeactivateStub, false,0,true 		);
		_details.addEventListener( ProjectDetails.LOAD_PROJECT_XML, _handleStubXmlRequest, false,0,true 	);
		_details.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleHeightChange, false,0,true 	);
		_details.addEventListener( ProjectDetails.HIDE_CASE_STUDY, _handleHideCaseStudy, false,0,true		);
		_details.addEventListener( ProjectDetails.CASE_STUDY_HIDDEN, _handleCaseStudyHidden, false,0,true	);
		
		// Position display items
		_stubHolder.x 	= StageMediator.stageLeft + OUTER_PADDING;
		_stubHolder.y   = RIBBON_Y_OPEN;
		_details.y		= 430;
		//_details.y		= 30000; // Temp
		_scrollHolder.x = OUTER_PADDING + 65;
		_scrollHolder.y = SCROLL_Y_OPEN;
		_moveDetails();
		
		// Add to display list
		super._baseMc.addChild( _scrollHolder );
		super._baseMc.addChild( _stubHolder );
		super._baseMc.addChild( _details );
		
		// Create stub ribbon
		var len:uint = $stubAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stub_vo:ProjectStub_VO  = $stubAr[i];
			var stub:ProjectStub		= new ProjectStub();
			stub.y = -30;
			stub.make( stub_vo );
			stub.addEventListener( ProjectStub.ACTIVATE_STUB, _handleActivateStub, false,0,true 				);
			stub.addEventListener( ProjectStub.DE_ACTIVATE_STUB, _handleDeactivateStub, false,0,true 			);
			// TODO: move the events of the details from the stub to the details. or at least investigate if it should be so
			_stubHolder.addChild( stub );
			_stubsAr.push( stub );
		}
		
		// Add event listeners for events fired from content
		super._baseMc.addEventListener( BtnEvent.SHOW_CASE_STUDY, _showCaseStudy, false,0,true );
		
		// display ribbon
		_displayAsRibbon();	
		//_moveRibbonVertical();	
		// Make visible
		
		super.show();
	}
	
	private function _createScrollBar (  ):void
	{
		var colorScheme:ColorScheme_VO 	= ColorSchemeProxy.currentColorScheme;
		//_scroller = new Scroller( _scrollHolder, 800, Scroller.HORIZONTAL, colorScheme.scrollbar_bar, colorScheme.scrollbar_track, colorScheme.scrollbar_track_border );
		_scroller = new Scroller( 800, 10 );
		_scroller.x = 13;
		_scroller.createDefaultScroller( colorScheme.scrollbar_bar, colorScheme.scrollbar_track, colorScheme.scrollbar_track_border, 4 );
		_scroller.build();
		
		_scroller.addEventListener( Scroller.SCROLL, _handleScroll, false,0,true );
		_scroller.addEventListener( Scroller.SCROLL_PRESSED, _handleScrollPress, false,0,true)
		_scroller.addEventListener( Scroller.SCROLL_RELEASED, _handleScrollRelease, false,0,true)
		_scrollHolder.addChild( _scroller );
	}
	
	// ______________________________________________________________ Vertical positioning
	
	private function _moveRibbonVertical (  ):void
	{
		var ribbonTargetY:uint;
		var scrollTargetY:uint;
		
		switch (_portfolioState ){
			case _BROWSING :
				ribbonTargetY = RIBBON_Y_BROWSING;
				scrollTargetY = SCROLL_Y_BROWSING;
				break;
			case _DETAILS :
				ribbonTargetY = RIBBON_Y_OPEN;
				scrollTargetY = SCROLL_Y_OPEN;
				break;
			case _FULL :
				ribbonTargetY = RIBBON_Y_OPEN;
				break;
		}
		
		//_stubHolder.y = ribbonTargetY;
		//_scrollHolder.y = scrollTargetY;
		
		Tweener.addTween( _stubHolder, { y:ribbonTargetY, time:1, transition:"EaseInOutQuint"} );
		Tweener.addTween( _scrollHolder, { y:scrollTargetY, time:1, transition:"EaseInOutQuint"} );
	}
	
	// ______________________________________________________________ Stub display
	
	private function _displayAsRibbon ( $tweenTime:Number=1 ):void
	{
		_ribbonWidth = 0;
		var len:uint = _stubsAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stub:ProjectStub = _stubsAr[i];
			// Make stub small if it's not the activestub
			if( stub != _activeStub && _activeStub != null) {
				if( _portfolioState == _FULL ) {
					//stub.setState( ProjectStub.TINY );
				}else{
					stub.setState( ProjectStub.SMALL );
				}
			}
			
			if( _portfolioState == _BROWSING || stub == _activeStub) 
				stub.brightenImage();
			else
				stub.dimImage();
			
			// Move to new position
			stub.moveTo( _ribbonWidth );
			_ribbonWidth += stub.stubWidth;
		}
		
		var newx:Number = ( _activeStub != null ) ? StageMediator.stageLeft - _activeStub.targetX + OUTER_PADDING
		 										  : StageMediator.stageLeft + OUTER_PADDING;
		
		Tweener.addTween( _stubHolder, { x:newx, time:$tweenTime, transition:"EaseInOutQuint", onUpdate:_setRealativePosition} );
		_updateHeight();
	}
	
	private function _activateStub ( $id:uint ):void
	{
		_activeStub = _stubsAr[ $id ];
		_resizeActiveStub();
		_displayAsRibbon();
	}
	
	private function _brightenOrDimStubs ( $doBrighten:Boolean ):void
	{
		var len:uint = _stubsAr.length;
		var i:uint;
		var stub:ProjectStub;
		
		if( _portfolioState != _BROWSING ){
			if( $doBrighten ){ 				// Brighten
				for ( i=0; i<len; i++ ) 
				{
					stub = _stubsAr[i];
					if( stub != _activeStub ) 
						stub.brightenImage(false,0,1,1);
				}
			} else {						// DimScroller
				//for ( i=0; i<len; i++ ) 
				//{
				//	stub = _stubsAr[i];
				//	if( stub != _activeStub ) 
				//		stub.dimImage(2);
				//}
			}
		}
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
		Tweener.addTween( this, { time:0.2, onComplete:_activeStub.bringToFront } );
	}
	
	// ______________________________________________________________ Details
	
	private function _changeDetails ( $vo:ProjectStub_VO ):void
	{
		_details.show();
		_details.changeContent( $vo );
	}
	
	private function _moveDetails (  ):void
	{
		if( _details != null )
			_details.x = StageMediator.stageLeft + OUTER_PADDING;
	}
	
	private function _hideDetails (  ):void
	{
		if( _details != null ) 
			_details.hide();
			
		_caseStudyIsVisible = false;
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
		
		x = Math.round(x);
		
		if( e.easeMotion ) 
			Tweener.addTween( _stubHolder, { x:x, time:0.5, onUpdate:_setRealativePosition} );
		else
			_stubHolder.x = x;			
	}
	
	private function _resizeScrollBar ( $speed:Number=1 ):void
	{
		if( _scroller != null ) {
			if( StageMediator.stageWidth < _ribbonWidth ) {
				_scroller.updateScrollWindow( StageMediator.stageWidth / _ribbonWidth, $speed );
				_scroller.show();
			}else{
				_scroller.hide();
			}			
		}

			
	}
	
	private function _resizeScrollTrack ( $speed:Number=1 ):void
	{
		if( _scroller != null ) {
			Tweener.addTween( _scrollHolder, { x:StageMediator.stageLeft + OUTER_PADDING - 12, time:$speed, transition:"EaseInOutQuint", onUpdate:_setRealativePosition} );
			_scroller.changeWidth( StageMediator.stageWidth - OUTER_PADDING * 2, $speed );
		}
	}
	
	private function _updateScrollBarPosition ( $speed:Number=1 ):void
	{
		if( _activeStub != null ) 
			_scroller.changeScrollPosition( _activeStub.arrayIndex / (_stubsAr.length - 1), $speed);
	}
	
	// ______________________________________________________________ Aligning the ribbon on stage resize
	
	private function _alignRibbonLeft ():void{
		if( _stubHolder != null )
			_stubHolder.x = StageMediator.stageLeft - _realativeXpos;
	}
	
	private function _setRealativePosition (  ):void{
		_realativeXpos = StageMediator.stageLeft - _stubHolder.x
	}
	
	// ______________________________________________________________ Event Handlers
	
	// Project stub
	public function _handleActivateStub     ( e:Event 	   ):void { sendNotification( SiteFacade.PROJECT_STUB_CLICK, e.target.arrayIndex );  };
	public function _handleDeactivateStub   ( e:Event=null ):void { sendNotification( SiteFacade.DEACTIVATE_STUB_CLICK	); };
	public function _handleStubXmlRequest   ( e:Event 	   ):void { sendNotification( SiteFacade.LOAD_PROJECT_XML, _alternateXml ); };
	public function _handleHeightChange     ( e:Event=null ):void { sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED 		); };
	private function _handleHideCaseStudy   ( e:Event 	   ):void {	sendNotification( SiteFacade.HIDE_CASE_STUDY_CLICK		); };
	private function _handleCaseStudyHidden ( e:Event 	   ):void {	sendNotification( SiteFacade.CASE_STUDY_HIDDEN			); };
	private function _handleScrollPress		( e:Event 	   ):void {	sendNotification( SiteFacade.PFLIO_SCROLL_PRESS			); };
	private function _handleScrollRelease	( e:Event 	   ):void {	sendNotification( SiteFacade.PFLIO_SCROLL_RELEASE		); };
	private function _showCaseStudy		 	( e:BtnEvent   ):void {	 
		sendNotification( SiteFacade.HIDE_CASE_STUDY		);
		sendNotification( SiteFacade.SHOW_CASE_STUDY, e.xmlFileIndex ); 
	}
	
	// Scrolling
	public function _handleScroll    ( e:ScrollEvent ):void{ sendNotification( SiteFacade.SCROLL_PORTFOLIO, e ); };
	
}
}