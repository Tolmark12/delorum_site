package swc_components
{

import flash.display.MovieClip;
import flash.text.TextField;

public class PortfolioItemText_swc extends MovieClip
{
	private var _titleTxt:TextField;
	private var _bodyTxt:TextField;
	
	public function PortfolioItemText_swc():void
	{
		var titleTxt:TitleTxt_swc  = new TitleTxt_swc();
		var bodyTxtMc:BodyText_swc = new BodyText_swc();
		this.addChild( bodyTxtMc );
		this.addChild( titleTxt  );
		bodyTxtMc.y = 40;
		titleTxt.y  = 10;
		
		_bodyTxt  = bodyTxtMc.txtField;
		_titleTxt = titleTxt.txtField;
	}
	
	public function set title ( $str:String ):void{ _titleTxt.text 		= $str;  };
	public function set body  ( $str:String ):void{ _bodyTxt.htmlText	= $str;  };
}

}