package site.view.sections.portfolio_components
{
import DelorumSite;
import flash.events.*;
import caurina.transitions.Tweener;
import flash.display.Sprite;
import site.model.vo.Row_VO;
import site.model.vo.Page_VO;
import site.model.vo.ColorScheme_VO;
import site.view.sections.portfolio_components.ProjectStub;
import site.model.ColorSchemeProxy;
import delorum.slides.SlideShow;
import delorum.slides.SlideShow_VO;

public class ProjectDetails extends Sprite
{	
	// Events
	public static const LOAD_PROJECT_XML :String  		= "load_project_xml";
	public static const HIDE_CASE_STUDY	 :String  		= "hide_case_study";
	public static const CASE_STUDY_HIDDEN:String  		= "case_study_hidden";
	
	
	// Btn
	private var _showDetailsBtn:CircleBtn_swc;
	
	// Sprites
	private var _rowManager:RowsManager;
	private var _bgMc:Sprite;
	private var _closeBtnTop:WhiteCloseBtn_swc;
	private var _closeBtnBtm:WhiteCloseBtn_swc;
	private var _slideShow:SlideShow;
	private var _contentHolder:Sprite;
	private var _mask:Sprite;
	
	private var _titleTxt:TitleTxt_swc;
	private var _bodyTxtMc:BodyText_swc;
	
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
		this.visible = false;
	}
	
	public function make (  ):void
	{
		_contentHolder 	= new Sprite();
		_showDetailsBtn = new CircleBtn_swc();
		_rowManager		= new RowsManager();
		_bgMc			= new Sprite();
		_closeBtnTop	= new WhiteCloseBtn_swc();
		_closeBtnBtm	= new WhiteCloseBtn_swc();
		_mask 			= new Sprite();
		
		// Background
		_bgMc.graphics.beginFill(0xFFFFFF);
		_bgMc.graphics.drawRect (-ProjectStub.BORDER_SIZE,0,ProjectStub.WIDTH_LARGE + ProjectStub.BORDER_SIZE + ProjectStub.BORDER_SIZE,351);
		_closeBtnBtm.x = _closeBtnTop.x = ProjectStub.WIDTH_LARGE + ProjectStub.BORDER_SIZE - 8;
		_closeBtnTop.y = -10;
		_closeBtnBtm.y = -5;
		
		// Rows
		_rowManager.y = 380;
		
		// Show Details button
		_showDetailsBtn.make( "Title", _showDetailsBtn.DOWN_ARROW );
		_showDetailsBtn.addEventListener( MouseEvent.CLICK, _handleShowDetailsClick );
		_showDetailsBtn.x = 20;//Column.COLUMN_WIDTH * 3 - _showDetailsBtn.width;
		_showDetailsBtn.y = 310;
				
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleMyHeightcChange );
		_closeBtnTop.addEventListener( MouseEvent.CLICK, _handleCloseClick );
		_closeBtnBtm.addEventListener( MouseEvent.CLICK, _handlePageCloseClick );
		
		var colorScheme:ColorScheme_VO = ColorSchemeProxy.currentColorScheme;
		
		// Textfields
		_titleTxt	= new TitleTxt_swc();
		_bodyTxtMc	= new BodyText_swc();

		_bodyTxtMc.txtField.width   = Column.COLUMN_WIDTH;
		_titleTxt.size				= DelorumSite.PROJECT_TITLE_FONT_SIZE;
		_bodyTxtMc.size				= 13;
		_titleTxt.color				= colorScheme.work_h1;
		_bodyTxtMc.color			= colorScheme.work_body;
		_bodyTxtMc.leading			= 12;

		_bodyTxtMc.y 				= 50;
		_titleTxt.y  				= 20;
		_titleTxt.x					= 20;
		_bodyTxtMc.x				= 20;
		
		
		
		_contentHolder.addChild( _bgMc 		 	 );
		_contentHolder.addChild( _bodyTxtMc  	 );
		_contentHolder.addChild( _titleTxt   	 );
		_contentHolder.addChild( _showDetailsBtn );

		this.addChild( _contentHolder );
		this.addChild( _closeBtnTop	  );
		this.addChild( _mask		  );
		this.addChild( _rowManager 	  );
		/*this.addChild( _closeBtnBtm   );*/
		
		// Mask
		_mask.graphics.beginFill(0xFFFF);
		_mask.graphics.drawRect(0,0,width,height+ 15);
		_contentHolder.mask = _mask;
	}
	
	public function unmake (  ):void
	{
		this.visible = false;
		this.scaleX = 1;
		this.scaleY = 1;
		_isHiding = false;
		
		if( _rowManager != null ) 
			closePage()
		
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	public function changeContent ( $title:String, $shortDescription:String, $slideShow:SlideShow_VO  ):void
	{
		_title 		 = $title;
		_body  		 = $shortDescription;
		_slideShowVo = $slideShow;
		
		_titleTxt.text 	 	= _title;
		_bodyTxtMc.htmlText = _body;
		
		if( _rowManager != null ) 
			_rowManager.removePage();
		
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
		
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	// ______________________________________________________________ Rows
	
	public function buildPage ( $page_vo:Page_VO ):void
	{
		Tweener.addTween(_rowManager, {alpha:1, time:0 })
		_rowManager.buildPage( $page_vo, _bgMc.width );
		_rowManager.addChild( _closeBtnBtm );
	}
	
	public function closePage (  ):void
	{
		_rowManager.hide( _removePage );
	}
	
	private function _removePage (  ):void
	{
		_rowManager.removePage();
		/*_rowManager.removeChild( _closeBtnBtm );*/
		dispatchEvent( new Event( CASE_STUDY_HIDDEN ) );
	}
	
	// ______________________________________________________________ Showing / hiding
	
	public function show (  ):void
	{
		if( _rowManager == null ) 
			make();
		
		if( this.visible == false )
		{
			this.visible = true;
			this.alpha = 1; //0
			//Tweener.addTween( this, { alpha:1, time:0.4, transition:"EaseOut"} );
			
			_mask.scaleY = 0;
			Tweener.addTween( _mask, { scaleY:1, x:0, time:0.9, transition:"EaseInOutQuint"} );
			dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
		}
	}
	
	public function hide (  ):void
	{
		if( !_isHiding )
		{
			_isHiding = true;
			//Tweener.addTween( _mask, { scaleY:0, time:0.2, transition:"EaseInOutQuint", onComplete:unmake} );
			Tweener.addTween( this, { alpha:0, time:0, transition:"EaseOutQuint", onComplete:unmake } );
		} 
	}

	
	// ______________________________________________________________ Event Handlers
	
	private function _handleShowDetailsClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(LOAD_PROJECT_XML) );
	}
	
	private function _handleMyHeightcChange ( e:Event ):void
	{
		//_bgMc.visible = true;
		//Tweener.addTween( _bgMc, { height:_rowManager.height + 20, time:0, transition:"EaseInOutQuint"} );
	}
	
	private function _handleContentChange ( e:Event ):void
	{
		//trace( "blech"  + '  :  ' + count++ );
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