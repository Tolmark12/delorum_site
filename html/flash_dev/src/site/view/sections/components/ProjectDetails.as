package site.view.sections.components
{
import DelorumSite;
import flash.events.*;
import caurina.transitions.Tweener;
import flash.display.Sprite;
import site.model.vo.Row_VO;
import site.model.vo.Page_VO;
import site.view.sections.components.ProjectStub;


public class ProjectDetails extends Sprite
{	
	// Events
	public static const LOAD_PROJECT_XML:String  		= "load_xml";
	
	// Btn
	private var _showDetailsBtn:CircleBtn_swc;
	
	// Sprites
	private var _rowManager:RowsManager;
	private var _bgMc:Sprite;
	
	// data
	private var _body:String;
	private var _title:String;
	
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
		
		// Background
		_bgMc.graphics.beginFill(0xFFFFFF);
		_bgMc.graphics.drawRect (0,0,ProjectStub.WIDTH_LARGE,10);
		_bgMc.visible = false;
		
		// Show Details button
		_showDetailsBtn.make( "Title", _showDetailsBtn.DOWN_ARROW );
		_showDetailsBtn.addEventListener( MouseEvent.CLICK, _handleShowDetailsClick );
		_showDetailsBtn.x = Column.COLUMN_WIDTH * 3 - _showDetailsBtn.width;
		_showDetailsBtn.y = 40;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleMyHeightcChange );

		
		// Textfields
		var titleTxt:TitleTxt_swc   = new TitleTxt_swc();
		var bodyTxtMc:BodyText_swc  = new BodyText_swc();
		bodyTxtMc.txtField.htmlText = _body;
		bodyTxtMc.txtField.width    = Column.COLUMN_WIDTH * 2;
		titleTxt.txtField.text 		= _title;
		titleTxt.size				= DelorumSite.PROJECT_TITLE_FONT_SIZE;
		bodyTxtMc.y 				= 40;
		titleTxt.y  				= 10;
		
		// Rows
		_rowManager.y = bodyTxtMc.y + bodyTxtMc.height + 20;
		
		this.addChild( _bgMc );
		this.addChild( bodyTxtMc );
		this.addChild( titleTxt  );
		this.addChild( _showDetailsBtn );
		this.addChild( _rowManager      );
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
		Tweener.addTween( _bgMc, { height:_rowManager.height + 20, time:0, transition:"EaseInOutQuint"} );
	}
	
	private function _handleContentChange ( e:Event ):void
	{
		trace( "blech"  + '  :  ' + count++ );
	}
	
	// ______________________________________________________________ Getters / Setters
	public function set title ( $str:String ):void{ _title = $str; };
	public function set body  ( $str:String ):void{ _body  = $str; };
}

}