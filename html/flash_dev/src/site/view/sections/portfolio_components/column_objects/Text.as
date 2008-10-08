package site.view.sections.portfolio_components.column_objects
{

import flash.text.TextField;
import site.model.CssProxy;
import flash.display.DisplayObject;

public class Text extends BaseColumnObj implements IColumnObject
{
	
	public var cssStyleList:Array;
	private var _bodyTxtSwc:BodyText_swc;
	
	public function Text():void
	{
		super();
	}
	
	override public function make ( $node:XML ):void
	{
		_bodyTxtSwc = new BodyText_swc();
		_bodyTxtSwc.clearAllFormatting();
		
		// TODO, move this into the swc class or somewhere. possiblly into the Css_VO object?
		var len:uint = cssStyleList.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			_bodyTxtSwc.parseCss( CssProxy.getCss( cssStyleList[i] )  );
		}
		
		_bodyTxtSwc.htmlText = String( $node.* );		
		this.addChild(_bodyTxtSwc);
		super.make($node);
		
		_fireHeightChange();
	}
	
	override public function setWidth ( $width:Number ):void
	{
		_bodyTxtSwc.textWidth = $width;
		_fireHeightChange()
	}
	
	override public function get myDispayThing (  ):DisplayObject
	{
		return _bodyTxtSwc;
	}
}

}