package swc_components
{

import flash.display.MovieClip;
import flash.text.*;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.*;

public class SwcText extends MovieClip
{
	private var _textField:TextField;
	private var _bitmap:Bitmap;
	private var _styleSheet:StyleSheet;
	private var _baseStyle:Object;
	
	public function SwcText():void
	{
		_styleSheet 			= new StyleSheet();
		_baseStyle				= new Object();
		_textField 				= this.getChildByName("textField") as TextField;
		_textField.autoSize 	= "left";
		this.addEventListener( Event.ADDED_TO_STAGE, _addBitmap )
	}
	
	private function _updateFormat (  ):void
	{
		_styleSheet.setStyle( "body", _baseStyle );
		_textField.styleSheet = _styleSheet;
		_addBitmap();
	}
	
	private function _addBitmap ( e:Event = null ):void
	{
		_textField.visible = true;
		
		if( _bitmap != null ) {
			this.removeChild(_bitmap);
		}
		var myBitmapData:BitmapData = new BitmapData(this.width, this.height, true, 0x000000);
		myBitmapData.draw( this );
		_bitmap = new Bitmap( myBitmapData );
		this.addChild( _bitmap );
		_textField.visible = false;
	}
	
	public function parseCss ( ...$cssObjects ):void
	{
		var len:uint = $cssObjects.length-1;
		for ( var i:int=len; i>=0; i-- ) 
		{
			trace( "css: " + $cssObjects[i] );
			_styleSheet.parseCSS( $cssObjects[i] );
		}
		_updateFormat();
	}
	
	private function _stripNewLines ( $str:String ):String
	{
		var look:RegExp = /\n/g;
		return $str.replace(look, "");
		//var htmlStr:String = "<a href='http://bewarz.of.warez.ru'>A dangerous link</a>";
		//var removeHTML:RegExp = new RegExp("<[^>]*>", "gi");
		//var safeStr:String = htmlStr.replace(removeHTML, "");
	}
	
	public function set text 		( $str:String ):void{ htmlText = $str; };
	public function set htmlText 	( $str:String ):void{ _textField.htmlText = "<body>" + _stripNewLines( $str ) + "</body>"; _updateFormat();  };
	
	public function get txtField (  ):TextField { return _textField; };
	public function set textWidth ( $val:uint ):void { _textField.width = $val; _addBitmap(); };
	public function get textWidth ():uint 			 { return _textField.textWidth; };
	public function set size ( $size:Number ):void { _baseStyle.fontSize = $size; _updateFormat();  };
	public function set color ( $hex:uint ):void { _baseStyle.color = $hex; _updateFormat() };
	public function set leading ( $leading:Number ):void {  _baseStyle.leading = $leading; _updateFormat(); };

}

}