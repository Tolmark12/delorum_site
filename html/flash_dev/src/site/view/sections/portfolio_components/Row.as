package site.view.sections.portfolio_components
{

import flash.display.*;
import site.model.*;
import site.model.vo.*;
import site.view.sections.portfolio_components.column_objects.*;
import caurina.transitions.Tweener;
import flash.events.*;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.StyleSheet;

public class Row extends Sprite
{
	public static const ROW_PADDING:Number = 20;
	
	
	private var _rowVo:Row_VO;
	private var _columnYpos:int;
	private var _bgColor:Shape;
	private var _holder:Sprite;
	private var _content:Sprite;
	private var _oldBitmap:Bitmap;
	private var _newBitmap:Bitmap;
	
	public function Row( $rowVo:Row_VO, $imagesDir:String, $width:Number ):void
	{
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
		
		_rowVo = $rowVo;
		_columnYpos = ROW_PADDING;
		
		_holder = new Sprite()
		this.addChild(_holder);
		
		// Add Background and Title
		_drawBg( $width );
			
		_content = new Sprite();
		_holder.addChild( _content );
			
		if( _rowVo.title != null ) 
			_addtitle();
			
		// Add columns
		_buildColumns( $imagesDir );
		
		alpha = 0;
		Tweener.addTween( this, { alpha:1, time:1, transition:"EaseInOutQuint"} );
//		_show();
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
		var bgColor:uint = _getCssBgColor();
		bgColor = ( _rowVo.bgColor == null )? bgColor : uint(_rowVo.bgColor) ;
		_bgColor = new Shape();
		_bgColor.visible = false;
		_bgColor.graphics.beginFill( bgColor );
		_bgColor.graphics.drawRect(0,0,$width,300);
		_holder.addChild(_bgColor);
	}
	
	private function _getCssBgColor (  ):uint
	{
		var tempStyleSheet:StyleSheet = new StyleSheet;
		
		// parse all css styles associated with this row
		var len:uint = _rowVo.cssStyleList.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var cssData:Css_VO = CssProxy.getCss( _rowVo.cssStyleList[i] );
			tempStyleSheet.parseCSS( cssData.toString() );
		}
		
		var bgColor:String = tempStyleSheet.getStyle("bg").color 
		// Replace the # with 0x
		return uint( bgColor.replace(/#/, "0x") );
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		if( _bgColor != null ) 
		{
			_bgColor.height = _content.height + ROW_PADDING*2;
			_bgColor.visible = true;
		}
//		_show();
	}
	
//	// ______________________________________________________________ Show
//	
//	private function _show (  ):void
//	{
//		/*if( _oldBitmap != null ) {
//			this.removeChild( _oldBitmap );
//			_oldBitmap = null;
//		}*/
//		
//		_holder.visible = true;
//		var myBitmapData:BitmapData = new BitmapData(_holder.width, _holder.height, true, 0x000000);
//		myBitmapData.draw( _holder );
//		_newBitmap = new Bitmap( myBitmapData );
//		this.addChild( _newBitmap );
//		_holder.visible = false;
//		
//		if( _oldBitmap != null )
//			_oldBitmap.visible = false;
//		
//		_newBitmap.alpha = 0;
//		Tweener.addTween( _newBitmap, { alpha:1, time:1, transition:"EaseInOutQuint", onComplete:_showTheRealContent} );
//	}
//	
//	private function _showTheRealContent (  ):void
//	{
//		//_oldBitmap.visible = false;
//		//_holder.visible = true;
//		
//		if( _oldBitmap != null )
//			this.removeChild( _oldBitmap );
//			
//		_oldBitmap = _newBitmap;
//		_holder.visible = true;
//	}

	
}

}