package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Page_VO;
import site.model.vo.Row_VO;
import site.view.sections.portfolio_components.ProjectStub;
import flash.events.*;

public class RowsManager extends Sprite
{
	private static const ROW_PADDING:Number = 10;
	
	private var _rows:Array;
	
	public function RowsManager():void
	{
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
	}
	
	public function buildPage ( $page_vo:Page_VO ):void
	{
		_rows = new Array();
		var len:uint = $page_vo.rowsAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var newRow:Row = new Row( $page_vo.rowsAr[i] as Row_VO, $page_vo.imagesDir );
			this.addChild(newRow);
			_rows.push(newRow);
		}
	}
	
	// ______________________________________________________________ Stacking rows
	
	private function _stackRows (  ):void
	{
		var yPos:Number = 0;
		
		var len:uint = _rows.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var row:Row = _rows[i] as Row;
			row.y = yPos;
			yPos = row.y + row.height + ROW_PADDING;
		}
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		_stackRows();
	}
}

}