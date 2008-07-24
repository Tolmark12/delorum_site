package site.view.sections.portfolio_components
{

import flash.display.Sprite;
import site.model.vo.Col_VO;
import site.view.sections.portfolio_components.column_objects.*;

public class Column extends Sprite
{
	// Size
	public static const COLUMN_WIDTH:uint  	= 266;
	public static const COLUMN_PADDING:uint	= 5;
	
	// xml tag constants
	private static const TEXT:String 		= "p";
	private static const IMG:String 		= "img";
	private static const IMAGE:String 		= "image";
	
	public var numberOfColumnsWide:uint;
	
	// ImagesDir
	private var _imagesDir:String;

	
	public function Column( $imagesDir ):void
	{
		_imagesDir = $imagesDir;
	}
	
	// ______________________________________________________________ Make
	
	public function make ( $col_vo:Col_VO ):void
	{
		numberOfColumnsWide = ( $col_vo.colSpan == 0 )? 1 : $col_vo.colSpan ;
		for each( var node:XML in $col_vo.content.children() );
		{
			// add all the items
			var item:BaseColumnObj = _createItem( node.localName().toLowerCase() );
			this.addChild(item);
			item.make( node );
			item.setWidth( numberOfColumnsWide * COLUMN_WIDTH - COLUMN_PADDING );
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
	
	
}

}