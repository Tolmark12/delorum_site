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
	
	// xml tag constants
	private static const TEXT:String 		= "txt";
	private static const IMG:String 		= "img";
	private static const IMAGE:String 		= "image";
	
	public var numberOfColumnsWide:uint;
	
	// ImagesDir
	private var _imagesDir:String;
	private var _itemAr:Array;
	
	public function Column( $imagesDir ):void
	{
		_imagesDir = $imagesDir;
		this.addEventListener( ProjectStub.CONTENT_HEIGHT_CHANGED, _stackItems );
	}
	
	// ______________________________________________________________ Make
	
	public function make ( $col_vo:Col_VO ):void
	{
		_itemAr = new Array();
		numberOfColumnsWide = ( $col_vo.colSpan == 0 )? 1 : $col_vo.colSpan ;
		//for each( var node:XML in $col_vo.content.children() );
		//{
		//	trace( String( $col_vo.content.img )  + '  :  ' +  node + '  :  ' + $col_vo.content.children().length() );
		//	// add all the items
		//	var item:BaseColumnObj = _createItem( node.localName().toLowerCase() );
		//	this.addChild(item);
		//	item.make( node );
		//	item.setWidth( numberOfColumnsWide * COLUMN_WIDTH - COLUMN_PADDING );
		//	_itemAr.push(item);
		//}
		
		var items:XMLList = $col_vo.content.children()
		var len:uint = items.length();
		for ( var i:uint=0; i<len; i++ ) 
		{
			trace( items[i].localName().toLowerCase() );
			// add all the items
			var item:BaseColumnObj = _createItem( items[i].localName().toLowerCase() );
			this.addChild(item);
			item.make( items[i] );
			item.setWidth( numberOfColumnsWide * COLUMN_WIDTH - COLUMN_PADDING );
			_itemAr.push(item);
		}
		
	}
	
	public function _createItem ( $tag ):BaseColumnObj
	{
		switch( $tag )
		{
			case TEXT :
				var newText:Text = new Text();
				return newText;
			case IMAGE :
			case IMG:
				var image:Image = new Image( $tag );
				image.imagesDir = _imagesDir;
				return image;
			default:
				var item:BaseColumnObj = new BaseColumnObj();
				return item;
		}		
	}
	
	public function _stackItems ( e:Event ):void
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
	
}

}