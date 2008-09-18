package site.view.sections.portfolio_components
{
import DelorumSite;
import flash.events.*;
import caurina.transitions.Tweener;
import flash.display.*;
import site.model.vo.*;
import site.view.sections.portfolio_components.ProjectStub;
import site.model.*;
import delorum.slides.SlideShow;
import delorum.slides.SlideShow_VO;

public class ProjectDetails extends Sprite
{	
	// Events
	public static const LOAD_PROJECT_XML :String  		= "load_project_xml";
	public static const HIDE_CASE_STUDY	 :String  		= "hide_case_study";
	public static const CASE_STUDY_HIDDEN:String  		= "case_study_hidden";
	
	// Sprites
	private var _rowManager:RowsManager;
	private var _rowMask:Sprite;
	private var _snapShotHolder:Sprite;
	private var _snapMask:Sprite;
	private var _snapHeight:Number = 0;
	
	private var _bgMc:Sprite;
	private var _slideShow:SlideShow;
	private var _contentHolder:Sprite;
	
	private var _bodyTxtMc:BodyText_swc;
	
	// snapshot
	private var _snapshot:Bitmap;
	
	// data
	private var _body:String;
	private var _title:String;
	private var _slideShowVo:SlideShow_VO;
	
	private var count:uint = 0;
	// Unmaking
	private var _isHiding:Boolean = false;
	
	public function ProjectDetails():void
	{
		this.alpha = 0;
		//this.visible = false;
	}
	
	public function make (  ):void
	{
		_contentHolder 	= new Sprite();
		_snapShotHolder = new Sprite();
		_rowManager		= new RowsManager();
		_bgMc			= new Sprite();
		_rowMask 		= new Sprite();
		_snapMask		= new Sprite();

		// Rows
		_rowManager.y = 0;
		
		// Height change
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleMyHeightcChange );
		
		// Color scheme object
		var colorScheme:ColorScheme_VO = ColorSchemeProxy.currentColorScheme;
		
		// Textfields
		_bodyTxtMc	= new BodyText_swc();
		_bodyTxtMc.txtField.width   = Column.COLUMN_WIDTH;
		_bodyTxtMc.y 				= 20;
		_bodyTxtMc.x				= 20;
		
		_contentHolder.addChild( _bgMc 		 	 );
		_contentHolder.addChild( _bodyTxtMc  	 );

		this.addChild( _rowMask		   );
		this.addChild( _rowManager 	   );
		this.addChild( _snapShotHolder );
		this.addChild( _snapMask 	   );
		
		// Masks
		var wid:Number = Column.COLUMN_PADDING*3 + Column.COLUMN_WIDTH*3
		_rowMask.graphics.beginFill(0xFF0000);
		_rowMask.graphics.drawRect( 0, 0, wid, 500 );
		_rowManager.mask = _rowMask;
		
		_snapMask.graphics.beginFill(0xFF0000);
		_snapMask.graphics.drawRect( 0, 0, wid, 700);
		_snapMask.x = wid;
		_snapMask.scaleX = -1;
		_snapShotHolder.mask = _snapMask;
		_handleShowDetailsClick();
	}
	
	public function unmake (  ):void
	{
		//this.visible = false;
		this.scaleX = 1;
		this.scaleY = 1;
		_isHiding = false;
		
		if( _rowManager != null ) 
			closePage()
		
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	// ______________________________________________________________ Changing the content
	
	public function changeContent ( $title:String, $vo:ProjectStub_VO ):void
	{
		trace( "change" );
		_title 		 = $title;
		_body  		 = $vo.shortDescription;
		_slideShowVo = $vo.slideShow;
		
		// Copy all the css styles
		_bodyTxtMc.clearAllFormatting();
		var len:uint = $vo.cssStyleList.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			_bodyTxtMc.parseCss( CssProxy.getCss( $vo.cssStyleList[i] )  );
		}
	
		_bodyTxtMc.htmlText = _body;
					
		if( _rowManager != null ) {
			_rowManager.removePage();
			_handleShowDetailsClick();
		}
		if( _slideShow != null ) {
			_contentHolder.removeChild( _slideShow );
			_slideShow = null;
		}
		
		if( _slideShowVo != null )
		{
			_slideShow		= new SlideShow( 508, 351, 5.5, 1.8 ); // w, h, displaytime, transSpeed
			_slideShow.x 	= Column.COLUMN_WIDTH + 27 + ProjectStub.BORDER_SIZE;
			_contentHolder.addChild( _slideShow );
			_slideShow.buildSlideShow( _slideShowVo );
		}
		
		_drawBg( $vo.bgColor );
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	// For transtioning. Create a snapshot of the current details so we
	// can slide the new content in over the top
	private function _createSnapShot (  ):void
	{
		if( _rowManager != null ) 
		{
			if( _rowManager.width > 0 && _rowManager.height > 0 )
			{
				if( _snapshot != null ) 
					_snapShotHolder.removeChild(_snapshot);
					
				var bmd:BitmapData = new BitmapData( _rowManager.width, _rowManager.height, true, 0x000000 );
				bmd.draw( this );
				_snapshot = new Bitmap(bmd);
				_snapShotHolder.addChild(_snapshot);
			}
		}
	}
	
	private function _drawBg ( $color ):void
	{
		// Background
		_bgMc.graphics.clear();
		_bgMc.graphics.beginFill( $color );
		_bgMc.graphics.drawRect (-ProjectStub.BORDER_SIZE,0,ProjectStub.WIDTH_LARGE + ProjectStub.BORDER_SIZE + ProjectStub.BORDER_SIZE,351);
	}
	
	// ______________________________________________________________ Rows
	
	public function buildPage ( $page_vo:Page_VO ):void
	{
		Tweener.addTween(_rowManager, {alpha:1, time:0 })
		_rowManager.buildPage( $page_vo, _bgMc.width );
	}
	
	public function closePage (  ):void
	{
		_rowManager.hide( _removePage );
	}
	
	private function _removePage (  ):void
	{
		_rowManager.removePage();
		dispatchEvent( new Event( CASE_STUDY_HIDDEN ) );
	}
	
	// ______________________________________________________________ Showing / hiding
	
	public function show (  ):void
	{
		_createSnapShot();
		
		if( _rowManager == null ) 
			make();

		this.visible = true;
		this.alpha = 1; //0
		//Tweener.addTween( this, { alpha:1, time:0.4, transition:"EaseOut"} );
		
		_snapMask.scaleX = -1;
		_rowMask.scaleX = 0;
		Tweener.addTween( _snapMask, { scaleX:0, time:0.9, transition:"EaseInOutQuint"} );
		Tweener.addTween( _rowMask, { scaleX:1,  time:0.9, transition:"EaseInOutQuint"} );
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	public function hide (  ):void
	{
		if( !_isHiding )
		{
			_isHiding = true;
			Tweener.addTween( _rowMask, { scaleY:0, time:0.2, transition:"EaseInOutQuint", onComplete:unmake} );
			//Tweener.addTween( this, { alpha:0, time:0, transition:"EaseOutQuint", onComplete:unmake } );
		} 
	}

	
	// ______________________________________________________________ Event Handlers
	
	private function _handleShowDetailsClick ( e:Event=null ):void
	{
		this.dispatchEvent( new Event(LOAD_PROJECT_XML) );
	}
	
	private function _handleMyHeightcChange ( e:Event ):void
	{
		trace( _rowManager.height + '  :  ' + this.height );
		if( this.height > 0  )
		{
			_rowMask.height = this.height + 20;
			_snapHeight = this.height + 20;
		}
	}
	
	private function _handleContentChange ( e:Event ):void
	{
	}
	
	private function _handleCloseClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(ProjectStub.DE_ACTIVATE_STUB, true) );
	}
	
	private function _handlePageCloseClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(HIDE_CASE_STUDY) );
	}
	
	// ______________________________________________________________ Getters / Setters
	public function set title  		( $str:String ):void{ _title = $str; };
	public function set body   		( $str:String ):void{ _body  = $str; };
	public function set slideShow 	( $slideShow:SlideShow_VO ):void { _slideShowVo = $slideShow; };
}

}