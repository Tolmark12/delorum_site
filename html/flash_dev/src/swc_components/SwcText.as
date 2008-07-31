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
	private var _format:TextFormat;
	private var _bitmap:Bitmap;
	
	public function SwcText():void
	{
		_textField = this.getChildByName("textField") as TextField;
		_textField.autoSize = "left";
		_format = new TextFormat();
		this.addEventListener( Event.ADDED_TO_STAGE, _addBitmap )
	}
	
	private function _updateFormat (  ):void
	{
		_textField.defaultTextFormat = _format;
		_textField.setTextFormat( _format );
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
	
	public function set text 		( $str:String ):void{ _textField.text = $str; 	  _updateFormat();  };
	public function set htmlText 	( $str:String ):void{ _textField.htmlText = $str; _updateFormat();  };
	
	public function get txtField (  ):TextField { return _textField; };
	public function set textWidth ( $val:uint ):void { _textField.width = $val; _addBitmap(); };
	public function get textWidth ():uint 			 { return _textField.textWidth; };
	public function set size ( $size:Number ):void { _format.size = $size; _updateFormat();  };
	public function set color ( $hex:uint ):void { _format.color = $hex; _updateFormat() };
	public function set leading ( $leading:Number ):void {  _format.leading = $leading; _updateFormat(); };

}

}