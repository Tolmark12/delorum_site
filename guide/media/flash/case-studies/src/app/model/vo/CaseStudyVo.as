package app.model.vo
{

public class CaseStudyVo
{
	public var index:Number;
	public var image:String;
	public var description:String;
	public var link:String;
	
	public function CaseStudyVo( $json:Object ):void
	{
		image			= $json.image;
		description 	= $json.description;
		link			= $json.link;
	}
}

}