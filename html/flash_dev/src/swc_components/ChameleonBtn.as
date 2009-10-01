package swc_components
{

import flash.display.MovieClip;
import flash.text.TextField;

public class ChameleonBtn extends MovieClip
{
	public static const CASE:String = "CASE";
	public static const WEB:String = "WEB";
	public static const NONE:String = "NONE";
	
	public var icons:MovieClip;
	public var titleTxt:TextField;
	public var url:String;
	
	public function ChameleonBtn():void
	{
		icons = this.getChildByName( "icons" ) as MovieClip;
		titleTxt = this.getChildByName( "titleTxt" ) as TextField;
		titleTxt.autoSize = "left";
		this.buttonMode = true;
		this.mouseChildren = false;
	}
	
	public function set text ( $text:String ):void
	{
		if( $text.length != 0 ) 
		{
			switch ($text.toUpperCase){
				case CASE :
					$text = "View full case study";
					icon = CASE;
				break;
				case WEB :
					$text = "Launch Website"
					icon = WEB;
				break;
			}
		}else{
			$text = "View full case study";
			icon = CASE;
		}
		
		titleTxt.text = $text;
	}
	
	public function set icon ( $icon:String ):void
	{
		if( $icon.length != 0 ) 
		{
			switch ($icon){
				case CASE :
					icons.gotoAndStop( CASE );
				break;
				case WEB :
					icons.gotoAndStop( WEB );
				break;
				case NONE :
					icons.gotoAndStop( NONE );
					titleTxt.x -= 22;
				break;
				default  :
					icons.gotoAndStop( $icon.toUpperCase() );
				break;
			}
		}
		
	}
	
	public function get textField (  ):TextField	{ return titleTxt; };
	
	

}

}