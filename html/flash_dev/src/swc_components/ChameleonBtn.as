package swc_components
{

import flash.display.MovieClip;
import flash.text.TextField;

public class ChameleonBtn extends MovieClip
{
	public static const CASE:String = "CASE";
	public static const WEB:String = "WEB";
	public static const NONE:String = "NONE";
	
	private var _icons:MovieClip;
	private var _titleTxt:TextField;
	
	public function ChameleonBtn():void
	{
		_icons = this.getChildByName( "icons" ) as MovieClip;
		_titleTxt = this.getChildByName( "titleTxt" ) as TextField;
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
		
		_titleTxt.text = $text;
	}
	
	public function set icon ( $icon:String ):void
	{
		if( $icon.length != 0 ) 
		{
			switch ($icon){
				case CASE :
					_icons.gotoAndStop( CASE );
				break;
				case WEB :
					_icons.gotoAndStop( WEB );
				break;
				case NONE :
					_icons.gotoAndStop( NONE );
					_titleTxt.x -= 22;
				break;
			}
		}
	}

}

}