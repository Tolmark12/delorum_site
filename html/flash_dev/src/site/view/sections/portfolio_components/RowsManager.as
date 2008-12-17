package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Page_VO;
import site.model.vo.Row_VO;
import site.view.sections.portfolio_components.ProjectStub;
import flash.events.*;
import flash.display.Bitmap;
import flash.display.BitmapData;
import caurina.transitions.Tweener;

public class RowsManager extends Sprite
{
	// List of rows
	private var _rows:Array;
	private var _contentSprite:Sprite;
	private var _bitmap:Bitmap;
	
	public function RowsManager(  ):void
	{
		_contentSprite = new Sprite();
		this.addChild( _contentSprite );
		_rows = new Array();
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
		_contentSprite.addEventListener( Row.ROW_INITIALIZED, _onRowInitialization );
	}
	
	// ______________________________________________________________ Building / Removing
	
	public function buildPage ( $page_vo:Page_VO, $width:Number ):void
	{
		_contentSprite.visible = true;
		// Add Rows
		var len:uint = $page_vo.rowsAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var newRow:Row = new Row( $page_vo.rowsAr[i] as Row_VO, $page_vo.imagesDir, $width );
			newRow.stackIndex = i;
			newRow.hide();
			_contentSprite.addChild(newRow);
			_rows.push(newRow);
		}
	}
	
	public function removePage (  ):void
	{
		var len:uint = _rows.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var row:Row = _rows.pop() as Row;
			row.destruct();
			_contentSprite.removeChild( row );
		}
	}
	
	// ______________________________________________________________ Show / Hide
	public function show (  ):void
	{
		_contentSprite.visible = true;
		Tweener.addTween( _contentSprite, {alpha:1, time:0  });
	}
	
	public function hide ( $callBackFunction:Function=null ):void
	{
		//var myBitmapData:BitmapData = new BitmapData(_contentSprite.width, _contentSprite.height, true, 0x000000);
		//myBitmapData.draw( _contentSprite );
		//_bitmap = new Bitmap( myBitmapData );
		//this.addChild( _bitmap );
		_contentSprite.visible = false;
		removePage();
		//Tweener.addTween( _bitmap, {alpha:0, time:1, onComplete:$callBackFunction });
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
			yPos = row.y + row.actualHeight -1;
		}
	}
	
	private function _makeRowsVisible ( $rowIndex:Number ):void
	{
		var doTestNextRowDown:Boolean = true;
		rowLoop : for ( var i:uint=0; i<$rowIndex+1; i++ ) 
		{
			trace( i + '  :  ' + _rows.length );
			var row:Row = _rows[i] as Row;
			if( !row.isInitialized ) {
				doTestNextRowDown = false;
				break rowLoop
			} else {
				row.show();
			}
		}
		
		if( doTestNextRowDown && $rowIndex != _rows.length -1 ) 
			_makeRowsVisible( $rowIndex + 1)
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _onRowInitialization ( e:Event ):void
	{
		var row:Row = e.target as Row;
		_makeRowsVisible( row.stackIndex );
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		_stackRows();
	}
}

}