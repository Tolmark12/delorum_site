package site.model.vo
{
public class Row_VO
{
	public var title:String;
	public var columnAr:Array;
	public var bgColor:String;
	public var bgWidth:Number;
	public var bgHeight:Number;
	public var bgAlpha:Number;
	public var bgAlphaMode:String;
	
	public var columnPadding :String
	public var padding:String
	public var totalColumns:String
	public var marginTop:String
	public var marginBottom:String
	public var background:String;
	
	//optional
	public var slideShowId:String;
	
	private var _cssStyleList:Array;
	
	
	// ______________________________________________________________ Getters / Setters
	
	public function set cssStyleList ( $val:Array ):void { _cssStyleList = $val; _cssStyleList.unshift("default") };
	public function get cssStyleList ():Array 			 { return _cssStyleList; };
	
	
	//temp
 	public function toString (  ):String
	{
		var str:String = "-----------"
		str += "title: " +          title +"\n";
		str += "columnAr: " +       columnAr +"\n";
		str += "bgColor: " +        bgColor +"\n";
		str += "bgWidth: " +        bgWidth +"\n";
		str += "bgHeight: " +       bgHeight +"\n";
		str += "bgAlpha: " +        bgAlpha +"\n";
		str += "bgAlphaMode: " +    bgAlphaMode +"\n";
		str += "columnPadding: " +  columnPadding +"\n";
		str += "padding: " +        padding +"\n";
		str += "totalColumns: " +   totalColumns +"\n";
		str += "marginTop: " +      marginTop +"\n";
		str += "marginBottom: " +   marginBottom +"\n";
		return str + "\n";
	}
}
}