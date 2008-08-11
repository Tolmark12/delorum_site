package site.model.vo
{
	
import delorum.slides.SlideShow_VO;

public class ProjectStub_VO
{
	public var arrayIndex		:uint;
	public var xmlPath			:String;
	public var image			:String;
	public var title			:String;
	public var shortDescription	:String;
	public var slideShow		:SlideShow_VO;
	
	public function set frameX ( $val:* ):void { _frameX = Number($val); };
	public function get frameX ():Number 			{ return _frameX; };
	public function set frameY ( $val:* ):void { _frameY = Number($val); };
	public function get frameY ():Number 			{ return _frameY; };
		
	// private vars
	private var _frameX			:Number;
	private var _frameY			:Number;
	
}

}