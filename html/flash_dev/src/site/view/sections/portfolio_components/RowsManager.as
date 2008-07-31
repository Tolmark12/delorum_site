package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Page_VO;
import site.model.vo.Row_VO;
import site.view.sections.portfolio_components.ProjectStub;
import flash.events.*;

public class RowsManager extends Sprite
{
	// List of rows
	private var _rows:Array;
	
	public function RowsManager(  ):void
	{
		_rows = new Array();
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
	}
	
	public function buildPage ( $page_vo:Page_VO, $width:Number ):void
	{
		// Add Rows
		var len:uint = $page_vo.rowsAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var newRow:Row = new Row( $page_vo.rowsAr[i] as Row_VO, $page_vo.imagesDir, $width );
			this.addChild(newRow);
			_rows.push(newRow);
		}
	}
	
	public function removePage (  ):void
	{
		var len:uint = _rows.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var row:Row = _rows.pop() as Row;
			this.removeChild( row );
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
			yPos = row.y + row.height;
		}
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		_stackRows();
	}
}

}