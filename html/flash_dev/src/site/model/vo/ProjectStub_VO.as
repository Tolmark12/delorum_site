package site.model.vo
{

public class ProjectStub_VO
{
	public var arrayIndex		:uint;
	public var xmlPath			:String;
	public var image			:String;
	public var title			:String;
	public var shortDescription	:String;
	
	public function set frameX ( $val:* ):void { _frameX = Number($val); };
	public function get frameX ():Number 			{ return _frameX; };
	
	// private vars
	private var _frameX			:Number;
	
}

}