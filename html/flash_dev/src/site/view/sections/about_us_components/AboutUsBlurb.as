package site.view.sections.about_us_components
{

import flash.display.MovieClip;
import flash.text.TextField;

public class AboutUsBlurb extends MovieClip
{
	
	private var _titleTxt:TextField;
	private var _numberTxt:TextField;
	
	public function AboutUsBlurb():void
	{
	   _titleTxt = this.getChildByName("titleTxt") as TextField;
	   _numberTxt = this.getChildByName("numberTxt") as TextField;
	}
	
	public function setText ( $htmlText:String, $css:String ):void
	{
		var txt:AboutUs_swc = new AboutUs_swc();
		txt.useBitmap = false;
		txt.y = 180;
		txt.clearAllFormatting();
		txt.parseCss( $css );
		txt.htmlText = $htmlText;		
		this.addChild( txt );
	}
	
	public function set title ( $str:String ):void{ _titleTxt.text = $str; };
	public function set number ( $str:String ):void{ _numberTxt.text = $str; };

}

}