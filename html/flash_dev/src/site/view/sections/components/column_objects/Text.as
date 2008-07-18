package site.view.sections.components.column_objects
{

import flash.text.TextField;
import DelorumSite;

public class Text extends BaseColumnObj implements IColumnObject
{
	
	private var _bodyTxtSwc:BodyText_swc;
	public function Text():void
	{
		super();
	}
	
	override public function make ( $node:XML ):void
	{
		super.make($node);
		_bodyTxtSwc 			= new BodyText_swc();
		_bodyTxtSwc.size 		= 4;
		_bodyTxtSwc.htmlText 	= String($node);
		this.addChild(_bodyTxtSwc);
		
		_fireHeightChange();
	}
	
	override public function setWidth ( $width:Number ):void
	{
		_bodyTxtSwc.textWidth = $width;
	}
	

}

}