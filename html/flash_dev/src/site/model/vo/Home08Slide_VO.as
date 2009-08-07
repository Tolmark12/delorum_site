package site.model.vo
{

public class Home08Slide_VO
{
	public var img:String;
	public var h1:String;
	public var body:String;
	public var href:String;
	
	public function Home08Slide_VO( $xml:XML ):void
	{
		img 	= $xml.img.@src;
		h1		= $xml.h1;
		body	= $xml.body;
		href	= $xml.@href;
	}
	
	public function get htmlText (  ):String
	{
		return "<h1>" + h1 + "</h1>" + "<p>" + body + "</p>";
	}
}

}