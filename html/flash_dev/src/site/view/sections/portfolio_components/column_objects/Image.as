package site.view.sections.portfolio_components.column_objects
{

import flash.display.Sprite;
import delorum.loading.ImageLoader;
import flash.events.*;

public class Image extends BaseColumnObj implements IColumnObject
{
	public var imagesDir:String;
	private var _imageHolder:Sprite;
	
	public function Image( $tag:String ):void
	{
		super();
	}
	
	override public function make ( $node:XML ):void
	{
		super.make($node);
		_imageHolder = new Sprite();
		this.addChild( _imageHolder );
		
		// Todo, create better error handling
		if( _getImagePath( $node ).indexOf(".jpg") != -1 ) 
		{
			
			var ldr:ImageLoader = new ImageLoader( _getImagePath( $node ), _imageHolder );
			ldr.onComplete	= _initImage;
			ldr.addItemToLoadQueue();	
		}
	}
	
	// ______________________________________________________________ Image loading
	
	private function _getImagePath ( $node:XML ):String
	{
		if( String($node.thmb).length != 0 ) 
			return imagesDir + $node.thmb.@src;
		if( String($node.@src).length != 0 ) 
			return imagesDir + $node.@src;
			
		return "";
	}
	
	private function _initImage ( e:Event ):void
	{
		_fireHeightChange();
	}
}


}