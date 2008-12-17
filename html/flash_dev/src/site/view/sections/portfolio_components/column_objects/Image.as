package site.view.sections.portfolio_components.column_objects
{

import flash.display.*;
import delorum.loading.ImageLoader;
import flash.events.*;

public class Image extends BaseColumnObj implements IColumnObject
{
	public var imagesDir:String;
	private var _imageHolder:Sprite;
	
	private var _imageName:String;
	public function Image():void
	{
		super();
	}
	
	override public function make ( $node:XML ):void
	{
		_imageName = _getImagePath( $node );
		_imageHolder = new Sprite();
		this.addChild( _imageHolder );
		trace( "loading image" + '  :  ' + _imageName );
		// Todo, create better error handling
		//if( _getImagePath( $node ).indexOf(".jpg") != -1 ) 
		//{
			var ldr:ImageLoader = new ImageLoader( _getImagePath( $node ), _imageHolder );
			ldr.onComplete	= _initImage;
			ldr.addItemToLoadQueue();	
		//}
		
		super.make($node);
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
		trace( "initing image"  + '  :  ' +  _imageName );
		_fireHeightChange();
		_fireInitialized();
	}
	
	override public function get myDispayThing (  ):DisplayObject
	{
		return _imageHolder;
	}
}


}