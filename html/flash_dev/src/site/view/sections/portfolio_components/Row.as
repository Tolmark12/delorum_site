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
	
	private var _width:Number;
	private var _rowVo:Row_VO;
	private var _columnYpos:int;
	private var _bgColor:Shape;
	private var _holder:Sprite;
	private var _content:Sprite;
	private var _oldBitmap:Bitmap;
	private var _newBitmap:Bitmap;
	
	// CSS Properties
	private var _cssBgColor:uint;
	private var _cssTotalColumns:uint;
	private var _cssPadding:uint;
	private var _cssMarginTop:Number;
	private var _cssMarginBottom:Number;
	private var _cssColumnPadding:uint;
	private var _columnWidth:Number;
	
	
	public function Row( $rowVo:Row_VO, $imagesDir:String, $width:Number ):void
	{
		_width = $width;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange );
		
		_rowVo = $rowVo;
		_columnYpos = ROW_PADDING;
		
		_holder = new Sprite()
		this.addChild(_holder);
		
		_setCssProperties();
		
		// Add Background and Title
		_drawBg( _width );
		_content = new Sprite();
		//_content.y = _cssMarginTop;
		_holder.addChild( _content );
			
		if( _rowVo.title != null ) 
			_addtitle();
			
		// Add columns
		_buildColumns( $imagesDir );
		
		//alpha = 0;
		//Tweener.addTween( this, { alpha:1, time:1, transition:"EaseInOutQuint"} );
//		_show();
	}
	
	// ______________________________________________________________ Make
	
	private function _buildColumns ( $imagesDir:String ):void
	{
		var columnWidth:Number = ( _width - _cssPadding*2 - ( _cssColumnPadding * ( _cssTotalColumns-1 ) )) / _cssTotalColumns;
		var len:uint = _rowVo.columnAr.length;
		var currentColumnPos = 0;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var col_vo:Col_VO = _rowVo.columnAr[i] as Col_VO;	
			var column:Column = new Column( $imagesDir, _rowVo.cssStyleList);
			_content.addChild(column);
			column.x = _cssPadding + (currentColumnPos * columnWidth) + (currentColumnPos * _cssColumnPadding);
			column.y = _cssMarginTop;
			column.addEventListener( Column.FLOAT, _handleColumnFloat );
			column.make( col_vo, columnWidth );
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
		var bgColor = ( _rowVo.bgColor == null )? _cssBgColor : uint(_rowVo.bgColor) ;
		_bgColor = new Shape();
		_bgColor.visible = false;
		_bgColor.graphics.beginFill( bgColor );
		_bgColor.graphics.drawRect(0,0,$width,300);
		_holder.addChild(_bgColor);
	}
	
	// Pull the bg color out of the css
	private function _setCssProperties (  ):void
	{
		var tempStyleSheet:StyleSheet = new StyleSheet;
		
		// parse all css styles associated with this row
		var len:uint = _rowVo.cssStyleList.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var cssData:Css_VO = CssProxy.getCss( _rowVo.cssStyleList[i] );
			tempStyleSheet.parseCSS( cssData.toString() );
		}
		
		var rowTag:Object = tempStyleSheet.getStyle("row");
		var bgColor:String 	= rowTag.bgColor;
		
		_cssBgColor        	= uint( bgColor.replace(/#/, "0x") );
		_cssColumnPadding  	= Number( rowTag.columnPadding );
		_cssPadding        	= Number( rowTag.padding );
		_cssTotalColumns	= uint( rowTag.columns  );
		_cssMarginTop		= Number( rowTag.marginTop );
		_cssMarginBottom	= Number( rowTag.marginBottom );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _handleColumnFloat ( e:Event ):void
	{
		var col:Column = e.currentTarget as Column;
		switch (col.float){
			case "right" :
				col.x = _width - col.colWidth;
			break;
			case "left":
				col.x = 0
			break;
		}
		
		col.y = 0;
	}
	
	private function _handleRowHeightChange ( e:Event ):void
	{
		if( _bgColor != null ) 
		{
			_bgColor.height = _content.height + _cssMarginTop + _cssMarginBottom;
			_bgColor.visible = true;
		}
	}

	
}

}