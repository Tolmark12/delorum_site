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
	public static const LOAD_PROJECT_XML:String  		= "load_xml";
	
	// Btn
	private var _showDetailsBtn:CircleBtn_swc;
	
	// Sprites
	private var _rowManager:RowsManager;
	private var _bgMc:Sprite;
	private var _closeBtn:WhiteCloseBtn_swc;
	private var _slideShow:SlideShow;
	
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
	}
	
	public function make (  ):void
	{
		_showDetailsBtn = new CircleBtn_swc();
		_rowManager		= new RowsManager();
		_bgMc			= new Sprite();
		_closeBtn		= new WhiteCloseBtn_swc();
		
		// Background
		_bgMc.graphics.beginFill(0xFFFFFF);
		_bgMc.graphics.drawRect (-ProjectStub.BORDER_SIZE,0,ProjectStub.WIDTH_LARGE + ProjectStub.BORDER_SIZE + ProjectStub.BORDER_SIZE,351);
		_closeBtn.x = ProjectStub.WIDTH_LARGE + ProjectStub.BORDER_SIZE - 8;
		_closeBtn.y = -10;
		//_bgMc.visible = false;
		
		// Show Details button
		_showDetailsBtn.make( "Title", _showDetailsBtn.DOWN_ARROW );
		_showDetailsBtn.addEventListener( MouseEvent.CLICK, _handleShowDetailsClick );
		_showDetailsBtn.x = Column.COLUMN_WIDTH * 3 - _showDetailsBtn.width;
		_showDetailsBtn.y = 40;
		
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleMyHeightcChange );
		_closeBtn.addEventListener( MouseEvent.CLICK, _handleCloseClick )
		
		var colorScheme:ColorScheme_VO = ColorSchemeProxy.currentColorScheme;
		
		// Textfields
		var titleTxt:TitleTxt_swc   = new TitleTxt_swc();
		var bodyTxtMc:BodyText_swc  = new BodyText_swc();
		bodyTxtMc.txtField.htmlText = _body;
		bodyTxtMc.txtField.width    = Column.COLUMN_WIDTH;
		titleTxt.txtField.text 		= _title;
		titleTxt.size				= DelorumSite.PROJECT_TITLE_FONT_SIZE;
		bodyTxtMc.size				= 13;
		titleTxt.color				= colorScheme.work_h1;
		bodyTxtMc.color				= colorScheme.work_body;
		bodyTxtMc.leading			= 12;

		bodyTxtMc.y 				= 50;
		titleTxt.y  				= 20;
		titleTxt.x					= 20;
		bodyTxtMc.x					= 20;
		
		// Rows
		_rowManager.y = bodyTxtMc.y + bodyTxtMc.height + 20;
		
		this.addChild( _bgMc 			);
		this.addChild( bodyTxtMc 		);
		this.addChild( titleTxt  		);
		//this.addChild( _showDetailsBtn 	);
		this.addChild( _rowManager      );
		if( _slideShowVo != null )
		{
			_slideShow		= new SlideShow();
			_slideShow.x 	= Column.COLUMN_WIDTH + 27 + ProjectStub.BORDER_SIZE;
			this.addChild( _slideShow );
			_slideShow.buildSlideShow( _slideShowVo );
		}
		this.addChild( _closeBtn		);
	}
	
	public function unmake (  ):void
	{
		var par:ProjectStub = this.parent as ProjectStub;
		par.removeDetailsMc( this );
	}
	
	// ______________________________________________________________ Rows
	
	public function buildPage ( $page_vo:Page_VO ):void
	{
		_rowManager.buildPage( $page_vo );
	}
	
	// ______________________________________________________________ Showing / hiding
	
	public function show (  ):void
	{
		if( _rowManager == null ) 
			make();
		this.visible = true;
		Tweener.addTween( this, { alpha:1, time:0.4, transition:"EaseInOutQuint"} );
		dispatchEvent( new Event(ProjectStub.CONTENT_HEIGHT_CHANGED) );
	}
	
	public function hide (  ):void
	{
		if( !_isHiding )
		{
			_isHiding = true;
			Tweener.addTween( this, { alpha:0, time:.1, transition:"EaseOutQuint", onComplete:unmake} );
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
		trace( "blech"  + '  :  ' + count++ );
	}
	
	private function _handleCloseClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(ProjectStub.DE_ACTIVATE_STUB, true) );
	}
	
	// ______________________________________________________________ Getters / Setters
	public function set title  		( $str:String ):void{ _title = $str; };
	public function set body   		( $str:String ):void{ _body  = $str; };
	public function set slideShow 	( $slideShow:SlideShow_VO ):void { _slideShowVo = $slideShow; };
}

}