package site.view.sections.home_08_components
{

import flash.display.Sprite;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.events.*;
import delorum.utils.echo;
import flash.geom.ColorTransform;

public class Buttons extends Sprite
{
	public function Buttons():void
	{

	}
	
	public function removeButtons (  ):void
	{
		var len:uint = this.numChildren;
		for ( var i:uint=0; i<len; i++ ) 
		{
			this.removeChildAt(0);
		}
	}
	
	public function addButtons ( $buttons:Array ):void
	{
		var yPos:Number = 28;
		var len:uint = $buttons.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var btn:ChameleonBtn_swc = new ChameleonBtn_swc();
			btn.text 	= $buttons[i].text;
			btn.icon 	= $buttons[i].icon;
			btn.url		= $buttons[i].url;
			btn.y 		= yPos * i;
			btn.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
			btn.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
			btn.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
			btn.dispatchEvent(new Event(MouseEvent.MOUSE_OUT));
			this.addChild(btn);
			
			var newColorTransform:ColorTransform = btn.icons.transform.colorTransform;
			newColorTransform.color = 0xD65C23;
			btn.icons.transform.colorTransform = newColorTransform;
			
			newColorTransform = btn.titleTxt.transform.colorTransform;
			newColorTransform.color = 0x6E6D6A;
			btn.titleTxt.transform.colorTransform = newColorTransform;
		}
	}
	
	// _____________________________ Event handlers
	
	private function _onClick ( e:Event ):void
	{
		var btn:ChameleonBtn_swc = e.currentTarget as ChameleonBtn_swc;
		var window:String = ( btn.url.indexOf("http:") == -1 )? '_self' : '_blank' ;
		echo( window + '  :  ' + btn.url + '  :  ' + btn );
		navigateToURL(new URLRequest( btn.url ), window);
	}
	
	private function _onMouseOver ( e:Event ):void {
		( e.currentTarget as Sprite ).alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		(e.currentTarget as Sprite).alpha = 0.8;
	}

}

}