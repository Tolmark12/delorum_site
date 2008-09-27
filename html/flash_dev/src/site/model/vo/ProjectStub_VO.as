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
	public var bgColor			:uint;
	public var row				:Row_VO;
	
	// private vars
	private var _frameX			:Number;
	private var _frameY			:Number;	private var _cssStyleList	:Array;
	
	// ______________________________________________________________ Getters / setters
	
	// frame positioning
	public function set frameX ( $val:* ):void { _frameX = Number($val); };
	public function get frameX ():Number 			{ return _frameX; };
	public function set frameY ( $val:* ):void { _frameY = Number($val); };
	public function get frameY ():Number 			{ return _frameY; };
	
	// css
	public function set cssStyleList ( $val:Array ):void { _cssStyleList = $val; _cssStyleList.unshift("default") };
	public function get cssStyleList ():Array 			 { return _cssStyleList; };
}

}