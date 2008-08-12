package site.model.vo
{
public class Row_VO
{
	public var title:String;
	public var columnAr:Array;
	public var bgColor:String;
	private var _cssStyleList:Array;
	
	
	// ______________________________________________________________ Getters / Setters
	
	public function set cssStyleList ( $val:Array ):void { _cssStyleList = $val; _cssStyleList.unshift("default") };
	public function get cssStyleList ():Array 			 { return _cssStyleList; };
}
}