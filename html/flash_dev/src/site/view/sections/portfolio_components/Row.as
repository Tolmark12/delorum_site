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
import flash.geom.*;
import delorum.loading.*;


public class Row extends RowBase
{
	// Constants
	public static const ROW_PADDING:Number = 20;
	
	// Events
	public static const ROW_INITIALIZED:String = "row_initialized";
	
	private var _width:Number;
	private var _rowVo:Row_VO;
	private var _columnYpos:int;
	private var _bgColor:Shape;
	private var _holder:Sprite;
	private var _content:Sprite;
	private var _oldBitmap:Bitmap;
	private var _newBitmap:Bitmap;
	private var _bgHeight:Number = -1;
	private var _columnAr:Array = new Array();
	
	// CSS Properties
	private var _cssBgColor:Array;
	private var _cssTotalColumns:uint;
	private var _cssPadding:uint;
	private var _cssMarginTop:Number;
	private var _cssMarginBottom:Number;
	private var _cssColumnPadding:uint;
	private var _columnWidth:Number;
	
	// Initialization
	private var _intializedColumns:Number = 0;
	private var _totalColumnObjects:Number;
	
	// 
	public var stackIndex:Number;
	public var isInitialized:Boolean = false;
	public var actualHeight:Number = 0;
	private var _hasBackgroundImage:Boolean = false;
	
	public function Row( $rowVo:Row_VO,  $width:Number ):void
	{
		_width = $width;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _handleRowHeightChange, false,0,true );
		
		_rowVo = $rowVo;
		_columnYpos = ROW_PADDING;
		
		_holder = new Sprite()
		this.addChild(_holder);
		
		_setCssProperties();
		
		// Add Background and Title
		_drawBg( _width );
		_addBackground( _rowVo.background )
		_content = new Sprite();
		_content.addEventListener( Column.COLUMN_INITIALIZED, _onColumnInitialized, false,0,true );
		//_content.y = _cssMarginTop;
		_holder.addChild( _content );
			
		// Add columns
	//	_buildColumns( $imagesDir );
	}
	
	// ______________________________________________________________ Make
	
	public function buildColumns ( $imagesDir:String="" ):void
	{
		var columnWidth:Number = ( _width - _cssPadding*2 - ( _cssColumnPadding * ( _cssTotalColumns-1 ) )) / _cssTotalColumns;
		var len:uint = _rowVo.columnAr.length;
		var currentColumnPos = 0;
		_totalColumnObjects = len;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var col_vo:Col_VO = _rowVo.columnAr[i] as Col_VO;	
			var column:Column = new Column( $imagesDir, _rowVo.cssStyleList);
			_content.addChild(column);
			column.x = _cssPadding + (currentColumnPos * columnWidth) + (currentColumnPos * _cssColumnPadding);
			column.y = _cssMarginTop;
			column.addEventListener( Column.FLOAT, _handleColumnFloat, false,0,true );
			column.make( col_vo, columnWidth );
			currentColumnPos += column.numberOfColumnsWide;
			_columnAr.push(column);
		}
	}
	
	private function _drawBg ( $width:Number ):void
	{
		/*var bgColor:uint   = ( _rowVo.bgColor == null )? _cssBgColor : uint(_rowVo.bgColor) ;*/
		var bgWidth:Number = ( _rowVo.bgWidth == -1 )? $width : _rowVo.bgWidth;
		var bgHeight:Number = ( _rowVo.bgHeight == -1 )? 300 : _rowVo.bgHeight;
		_bgHeight = _rowVo.bgHeight;

		_bgColor = new Shape();
		_bgColor.visible = false;
		
		// No gradient
		if( _cssBgColor.length < 2 ) 
			_bgColor.graphics.beginFill( _cssBgColor[0], _rowVo.bgAlpha );
		// Gradient
		else {
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(bgHeight, bgWidth, 0, 0, 0);
			gradientMatrix.rotate(1.57079633);
		  
			_bgColor.graphics.beginGradientFill( "linear", _cssBgColor, [1,1], [0, 255], gradientMatrix  );
			_bgColor.alpha = _rowVo.bgAlpha;
		}
		_bgColor.graphics.drawRect(0,0,bgWidth,bgHeight);
		_holder.addChild(_bgColor);
	}
	
	private function _addBackground ( $bg:String ):void
	{
		if( $bg != "-1" ) 
		{
			_hasBackgroundImage = true;
			var _imageHolder:Sprite = new Sprite();
			_holder.addChild(_imageHolder);
			var ldr:ImageLoader = new ImageLoader( $bg, _imageHolder );
			ldr.addEventListener( Event.COMPLETE, _dispatchHeightChange, false,0,true );
			ldr.loadItem();
		}
	}
	
	// Pull the bg color out of the css
	private function _setCssProperties (  ):void
	{
		_cssColumnPadding  	= Number( _rowVo.columnPadding );
		_cssPadding        	= Number( _rowVo.padding );
		_cssTotalColumns	= uint( _rowVo.totalColumns  );
		_cssMarginTop		= Number( _rowVo.marginTop );
		_cssMarginBottom	= Number( _rowVo.marginBottom );
		
		var bgArray:Array 	= _rowVo.bgColor.split("-");
		_cssBgColor        	= new Array();
		var len:uint = bgArray.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			_cssBgColor.push( uint( bgArray[i].replace(/#/, "0x") ) );
		}
		
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
		_dispatchHeightChange()
	}
	
	private function _dispatchHeightChange ( e:Event=null ):void
	{
		this.dispatchEvent( new Event( ProjectStub.CONTENT_HEIGHT_CHANGED, true ) );
	}
	
	private function _handleRowHeightChange ( e:Event=null ):void
	{
		if( _bgColor != null ) 
		{
			if( _bgHeight == -1 ) 
				_bgColor.height = _content.height + _cssMarginTop + _cssMarginBottom;
			
			// Set actual height
			actualHeight = 0;
			var len:uint = _content.numChildren;
			for ( var i:uint=0; i<len; i++ ) 
			{
				var col:Column = _content.getChildAt(i) as Column;
				actualHeight = (col.colHeight > actualHeight)? col.colHeight : actualHeight ;
			}
			_bgColor.visible = true;
		}

		actualHeight = _bgColor.height;
		if( _hasBackgroundImage )
		 	actualHeight = (_holder.height > actualHeight )? _holder.height : actualHeight ;
			
	}
	
	override public function destruct (  ):void
	{
		var len:uint = _columnAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var column:Column = _columnAr.pop() as Column;
			column.destruct();
			_content.removeChild( column );
		}
	}
	
	private function _onColumnInitialized ( e:Event ):void
	{
		e.stopPropagation();
		if( _totalColumnObjects == ++_intializedColumns ) {
			isInitialized = true;
			this.dispatchEvent( new Event( ROW_INITIALIZED, true ) );
		}
		
	}
}

}