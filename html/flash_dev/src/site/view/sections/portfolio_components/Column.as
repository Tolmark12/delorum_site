package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Col_VO;
import site.view.sections.portfolio_components.column_objects.*;
import flash.events.*;
import site.view.sections.portfolio_components.ProjectStub;

public class Column extends Sprite
{
	// Size
	public static const COLUMN_PADDING:uint	= 12;
	public static const COLUMN_WIDTH:uint  	= 266;// - COLUMN_PADDING*4;
	public static const FLOAT:String = "float";
	
	// xml tag constants !!-should be lowercase-!!
	private static const TEXT:String 		= "txt";
	private static const IMG:String 		= "img";
	private static const IMAGE:String 		= "image";
	private static const SLIDE_SHOW:String 	= "slideshow";
	
	public var numberOfColumnsWide:uint;
	
	// Width
	private var _actualWidth:Number;
	private var _colWidth:Number;
	public var float:String;
	
	// ImagesDir
	private var _imagesDir:String;
	private var _cssStyleList:Array;
	private var _itemAr:Array;
	private var _alignment:String;
	
	public function Column( $imagesDir:String, $cssStyleList:Array ):void
	{
		_colWidth = 0;
		_imagesDir = $imagesDir;
		_cssStyleList = $cssStyleList;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _refreshContent );
	}
	
	// ______________________________________________________________ Make
	
	public function make ( $col_vo:Col_VO, $columnWidth:Number ):void
	{
		float					= $col_vo.float;
		_alignment 				= $col_vo.align;
		_itemAr 				= new Array();
		numberOfColumnsWide 	= ( $col_vo.colSpan == 0 )? 1 : $col_vo.colSpan ;
		_colWidth 				= $columnWidth * numberOfColumnsWide;
		
		var items:XMLList = $col_vo.content.children()
		var len:uint = items.length();
		for ( var i:uint=0; i<len; i++ ) 
		{
			// add all the items
			var item:BaseColumnObj = _createItem( items[i].localName().toLowerCase() );
			_itemAr.push(item);
			this.addChild(item);
			item.make( items[i] );
			item.setWidth( _colWidth );
		}
		
	}
	
	public function _createItem ( $tag ):BaseColumnObj
	{
		switch( $tag )
		{
			case TEXT :
				var newText:Text = new Text();
				newText.cssStyleList = _cssStyleList;
				return newText;
			case IMAGE :
			case IMG:
				var image:Image = new Image();
				image.imagesDir = _imagesDir;
				return image;
			case SLIDE_SHOW:
				var slide:Slides = new Slides();
				slide.imagesDir = _imagesDir;
				return slide;
			default:
				var item:BaseColumnObj = new BaseColumnObj();
				return item;
		}		
	}
	
	
	private function _refreshContent ( e:Event ):void
	{
		_updateWidth()
		_align();
		_stackItems();
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
		switch (_alignment){
			case "right" :
				for ( i=0; i<len; i++ ) 
				{
					item = _itemAr[i] as BaseColumnObj;
					item.x = _colWidth - item.myWidth;
				}
			break;
			case "center" :
				for( i=0; i<len; i++ ) 
				{
					item = _itemAr[i] as BaseColumnObj;
					item.x = _colWidth/2 - item.myWidth/2;
				}
			break;
			default:
				for ( i=0; i<len; i++ ) 
				{
					item = _itemAr[i] as BaseColumnObj;
					item.x = 0;
				}
			break;
		}
	}
	
	private function _stackItems (  ):void
	{
		var yPos:Number = 0;
		var len:uint = _itemAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var item:BaseColumnObj = _itemAr[i];
			item.y = yPos;
			yPos += item.height;
		}
	}
	
	private function _updateWidth (  ):void
	{
		_actualWidth = 0;
		var len:uint = _itemAr.length;
		var item:BaseColumnObj
		
		for ( var i:uint=0; i<len; i++ ) 
		{
			item = _itemAr[i] as BaseColumnObj;
			_actualWidth = item.myWidth ;
		}
	}
	// ______________________________________________________________ getters / setters
	
	public function get colWidth (  ):Number{ return _actualWidth; };
	
}

}