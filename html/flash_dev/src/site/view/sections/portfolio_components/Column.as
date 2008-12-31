package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Col_VO;
import site.view.sections.portfolio_components.column_objects.*;
import flash.events.*;
import site.view.sections.portfolio_components.ProjectStub;

public class Column extends Sprite
{
	// Events
	public static const COLUMN_INITIALIZED:String = "column_initialized";
	
	// Size
	public static const COLUMN_PADDING:uint	= 12;
	public static const COLUMN_WIDTH:uint  	= 266;// - COLUMN_PADDING*4;
	public static const FLOAT:String = "float";
	
	// xml tag constants !!-should be lowercase-!!
	private static const BTN:String 		= "btn";
	private static const TEXT:String 		= "txt";
	private static const IMG:String 		= "img";
	private static const IMAGE:String 		= "image";
	private static const VIDEO:String 		= "video";
	private static const SLIDE_SHOW:String 	= "slideshow";
	
	public var numberOfColumnsWide:uint;
	
	// Width
	private var _actualWidth:Number;
	private var _colWidth:Number;
	
	//
	public var float:String;
	
	//
	private var _actualHeight:Number;
	
	// ImagesDir
	private var _imagesDir:String;
	private var _cssStyleList:Array;
	private var _itemAr:Array;
	private var _totalItems:Number;
	private var _initializedItems:Number = 0;
	private var _alignment:String;
	
	// Content
	private var _stackDirection:String = "vertical";
	private var _stackPadding:Number;
	
	public function Column( $imagesDir:String, $cssStyleList:Array ):void
	{
		_colWidth = 0;
		_imagesDir = $imagesDir;
		_cssStyleList = $cssStyleList;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _refreshContent, false,0,true );
		this.addEventListener( BaseColumnObj.INITIALIZED, _onColumnObjInit, false,0,true );
	}
	
	// ______________________________________________________________ Make
	
	public function make ( $col_vo:Col_VO, $columnWidth:Number ):void
	{
		float					= $col_vo.float;
		_alignment 				= $col_vo.align;
		_stackDirection			= $col_vo.stack;
		_stackPadding			= Number($col_vo.stackPadding);
		_itemAr 				= new Array();
		numberOfColumnsWide 	= ( $col_vo.colSpan == 0 )? 1 : $col_vo.colSpan ;
		_colWidth 				= $columnWidth * numberOfColumnsWide;
		
		
		var items:XMLList = $col_vo.content.children()
		var len:uint = items.length();
		_totalItems = len;
		for ( var i:uint=0; i<len; i++ ) 
		{
			// add all the items
			var item:BaseColumnObj = _createItem( items[i].localName().toLowerCase() );
			_itemAr.push(item);
			this.addChild(item);
			item.make( items[i] );
			item.setWidth( _colWidth );
		}
		
		if( len == 0 ) 
			this.dispatchEvent( new Event(COLUMN_INITIALIZED, true) );
		
	}
	
	public function _createItem ( $tag ):BaseColumnObj
	{
		switch( $tag )
		{
			case TEXT :
				var newText:Text = new Text();
				newText.cssStyleList = _cssStyleList;
				return newText;
			case BTN :
				var btn:Btn = new Btn();
				return btn;
			case IMAGE :
			case IMG:
				var image:Image = new Image();
				image.imagesDir = _imagesDir;
				return image;
			case SLIDE_SHOW:
				var slide:Slides = new Slides();
				slide.imagesDir = _imagesDir;
				return slide;
			case VIDEO :
				var video:Video = new Video();
				return video;
			default:
				var item:BaseColumnObj = new BaseColumnObj();
				return item;
		}		
	}
	
	
	private function _refreshContent ( e:Event ):void
	{
		_updateWidthAndHeight()
		_align();
		_updateFloat();
	}
	
	private function _updateFloat (  ):void
	{
		if( float != null )
			this.dispatchEvent( new Event( FLOAT ) );
	}
	
	private function _align (  ):void
	{
		var len:uint = _itemAr.length;
		var i:uint;
		var item:BaseColumnObj;
		var xPos:Number = 0;
		var yPos:Number = 0;
		
		switch (_alignment){
			case "right" :
				if(_stackDirection == "vertical"){				// Right Vertical
					for ( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = _colWidth - item.myWidth;
						item.y = yPos;
						yPos += item.height + _stackPadding;
					}
				}else if(_stackDirection == "horizontal"){
					xPos = _colWidth;
					for ( i=0; i<len; i++ ) {					// Right Horizontal
						item = _itemAr[i] as BaseColumnObj;
						xPos -= item.myWidth + _stackPadding;
						item.x = xPos;
					}
				}else{											// Right No Stacking
					for ( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = _colWidth - item.myWidth;
						item.y = 0;
					}
				}
			break;
			case "center" :
				var centerPoint:Number = _colWidth/2;
				if(_stackDirection == "vertical"){				// Center Vertical
					for( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = centerPoint - item.myWidth/2;
						item.y = yPos;
						yPos += item.height + _stackPadding;
					}
				}else if(_stackDirection == "horizontal"){		// Center Horizontal
					var totalWidth:Number = -_stackPadding;
					for ( i=0; i<len; i++ ){
						item = _itemAr[i] as BaseColumnObj;
						totalWidth += item.myWidth + _stackPadding;
					}
					
					xPos = centerPoint - totalWidth/2;
					for( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = xPos;
						xPos += item.myWidth + _stackPadding;
					}
				}else{											// Center No Stacking
					for ( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = centerPoint - item.myWidth/2;
						item.y = 0;
					}
				}
			break;
			default:
				if(_stackDirection == "vertical"){				// Left Vertical
					for ( i=0; i<len; i++ ){
						item = _itemAr[i] as BaseColumnObj;
						item.x = 0;
						item.y = yPos;
						yPos += item.height + _stackPadding;
					}
				}else if(_stackDirection == "horizontal"){		// Left Horizontal
					for ( i=0; i<len; i++ ){
						item = _itemAr[i] as BaseColumnObj;
						item.x = xPos;
						xPos += item.myWidth + _stackPadding;
					}
				}else{											// Left No Stacking
					for ( i=0; i<len; i++ ) {
						item = _itemAr[i] as BaseColumnObj;
						item.x = 0;
						item.y = 0;
					}
				}
			break;
		}
	}
	
	private function _updateWidthAndHeight (  ):void
	{
		_actualWidth = 0;
		var len:uint = _itemAr.length;
		var item:BaseColumnObj
		
		for ( var i:uint=0; i<len; i++ ) 
		{
			item = _itemAr[i] as BaseColumnObj;
			_actualWidth  = (item.myWidth  >_actualWidth   )? item.myWidth  : _actualWidth;
			_actualHeight = (item.myHeight > _actualHeight )? item.myHeight : _actualHeight;
		}
	}

	public function destruct (  ):void
	{
		var len:uint = _itemAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var item:BaseColumnObj = _itemAr.pop();
			item.destruct();
			this.removeChild(item);
		}
	}
	
	// ______________________________________________________________ Event Handlers
	private function _onColumnObjInit ( e:Event ):void
	{
		// Stop the event from bubbling further
		e.stopPropagation();
		
		// If all column items are initialized
		if( _totalItems == ++_initializedItems )
			this.dispatchEvent( new Event(COLUMN_INITIALIZED, true) );
	}
	
	
	// ______________________________________________________________ getters / setters
	
	public function get colWidth (  ):Number{ return _actualWidth; };
	public function get colHeight (  ):Number{ return _actualHeight; };
	
}

}