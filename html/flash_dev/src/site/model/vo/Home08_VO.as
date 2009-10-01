package site.model.vo
{

public class Home08_VO
{
	public var rightBlurbH1:String;
	public var rightBlurbTxt:String;
	public var leftBlurbH1:String;
	public var leftBlurbTxt:String;
	public var slideCss:String;
	public var blurbCss:String;
	public var slides:Array = new Array();
	public var xml:XML;
	public var lowerRightImage:String;
	
	public function Home08_VO( $xml:XML ):void
	{
		xml 			= $xml;
		lowerRightImage	= $xml.image.@src;
		rightBlurbH1	= $xml.blurbs.rightBlurb.h1;
		rightBlurbTxt  	= $xml.blurbs.rightBlurb.body;
		leftBlurbH1		= $xml.blurbs.leftBlurb.h1;
		leftBlurbTxt  	= $xml.blurbs.leftBlurb.body;
		trace( );
		blurbCss		= String( $xml.css.blurb.* );
		slideCss		= String( $xml.css.main.* );
		_createSlides( $xml.slides );
	}
	
	private function _createSlides ( $xml:XMLList ):void
	{
		for each( var slide:XML in $xml.slide ){
			slides.push( new Home08Slide_VO( slide ) )
		}
	}
	
	public function getHtmlText ( $side:String ):String
	{
		if( $side == "right" )
			return "<h1>" + rightBlurbH1 + "</h1>" + "<p>" + rightBlurbTxt + "</p>";
		else
			return "<h1>" + leftBlurbH1 + "</h1>" + "<p>" + leftBlurbTxt + "</p>";
	}
}

}