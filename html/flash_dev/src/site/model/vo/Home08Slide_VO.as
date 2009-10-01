package site.model.vo
{

public class Home08Slide_VO
{
	public var img:String;
	public var h1:String;
	public var body:String;
	public var href:String;
	public var buttons:Array;
	
	public function Home08Slide_VO( $xml:XML ):void
	{
		img 	= $xml.img.@src;
		h1		= $xml.h1;
		body	= $xml.body;
		href	= $xml.@href;
		buttons = new Array();
		for each( var btn:XML in $xml.btns.btn)
		{
			var obj:Object 	= {};
			obj.text 		= btn.@text;
			obj.url 		= btn.@url;
			obj.icon		= btn.@icon;
			buttons.push(obj);
		}
	}
	
	public function get htmlText (  ):String
	{
		return "<h1>" + h1 + "</h1>" + "<p>" + body + "</p>";
	}
}

}