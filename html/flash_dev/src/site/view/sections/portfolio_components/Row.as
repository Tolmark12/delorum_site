package site.view.sections.portfolio_components
{

import flash.display.*;
import site.model.ColorSchemeProxy;
import site.model.vo.ColorScheme_VO;
import site.model.vo.Row_VO;
import site.model.vo.Col_VO;
import site.view.sections.portfolio_components.column_objects.*;
import caurina.transitions.Tweener;
import flash.events.*;

public class Row extends Sprite
{
	public static const ROW_PADDING:Number = 20;
	
	
	private var _rowVo:Row_VO;
	private var _columnYpos:int;
	private var _bgColor:Shape;
	private var _content:Sprite;
	
	public function Row( $rowVo:Row_VO, $imagesDir:String, $width:Number ):void
	{
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
		
		alpha = 0;
		Tweener.addTween( this, { alpha:1, time:1, transition:"EaseInOutQuint"} );
		_rowVo = $rowVo;
		_columnYpos = ROW_PADDING;
		
		// Add Background and Title
		if( _rowVo.bgColor != -1 ) 
			_drawBg( $width );
			
		_content = new Sprite();
		this.addChild( _content );
			
		if( _rowVo.title != null ) 
			_addtitle();
			
		// Add columns
		_buildColumns( $imagesDir );
	}
	
	// ______________________________________________________________ Make
	
	private function _buildColumns ( $imagesDir:String ):void
	{
		
		var len:uint = _rowVo.columnAr.length;
		var currentColumnPos = 0;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var col_vo:Col_VO = _rowVo.columnAr[i] as Col_VO;	
			var column:Column = new Column( $imagesDir );
			_content.addChild(column);
			column.make( col_vo );
			column.x = currentColumnPos * Column.COLUMN_WIDTH + Column.COLUMN_PADDING;
			column.y = _columnYpos;
			currentColumnPos += column.numberOfColumnsWide;
		}
	}
	
	private function _addtitle (  ):void
	{
		var colorScheme:ColorScheme_VO 	= ColorSchemeProxy.currentColorScheme;
		var titleTxt:TitleTxt_swc  = new TitleTxt_swc();
		titleTxt.y	   = ROW_PADDING;
		titleTxt.x 	   = Column.COLUMN_PADDING;
		titleTxt.text  = _rowVo.title;
		titleTxt.size  = DelorumSite.H1_FONT_SIZE;;
		titleTxt.color = colorScheme.work_h2;
		_content.addChild(titleTxt);
		_columnYpos = titleTxt.height + titleTxt.y + 6;
	}
	
	private function _drawBg ( $width:Number ):void
	{
		_bgColor = new Shape();
		_bgColor.visible = false;
		_bgColor.graphics.beginFill(_rowVo.bgColor);
		_bgColor.graphics.drawRect(0,0,$width,300);
		this.addChild(_bgColor);
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		if( _bgColor != null ) 
		{
			_bgColor.height = _content.height + ROW_PADDING*2;
			_bgColor.visible = true;
		}
	}
	
	
}

}