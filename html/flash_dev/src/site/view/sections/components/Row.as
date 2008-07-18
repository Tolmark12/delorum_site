package site.view.sections.components
{

import flash.display.Sprite;
import site.model.vo.Row_VO;
import site.model.vo.Col_VO;
import site.view.sections.components.column_objects.*;
import caurina.transitions.Tweener;

public class Row extends Sprite
{
	private var _rowVo:Row_VO;
	private var _columnYpos:int = 0; 
	
	public function Row( $rowVo:Row_VO, $imagesDir:String ):void
	{
		alpha = 0;
		Tweener.addTween( this, { alpha:1, time:1, transition:"EaseInOutQuint"} );
		_rowVo = $rowVo;
		if( _rowVo.title != null ) 
			_addtitle();
			
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
			column.make( col_vo );
			column.x = currentColumnPos * Column.COLUMN_WIDTH;
			column.y = _columnYpos;
			currentColumnPos += column.numberOfColumnsWide;
			this.addChild(column);
		}
	}
	
	private function _addtitle (  ):void
	{
		var titleTxt:TitleTxt_swc  = new TitleTxt_swc();
		titleTxt.text = _rowVo.title;
		titleTxt.size = DelorumSite.H1_FONT_SIZE;;
		this.addChild(titleTxt);
		_columnYpos = titleTxt.height + 6;
	}
	
	
}

}