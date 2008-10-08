package site.view.sections.portfolio_components.column_objects
{

import flash.display.*;
import flash.events.*;
public class Btn extends BaseColumnObj
{
	private var _swcBtn:ChameleonBtn_swc;
	private var _clickEvent:String;
	
	public function Btn():void
	{
		
	}
	
	override public function make ( $node:XML ):void
	{
		_swcBtn = new ChameleonBtn_swc();
		_swcBtn.useHandCursor = true;
		_swcBtn.addEventListener( MouseEvent.CLICK, _click );
		_clickEvent = $node.@event;
		trace( _clickEvent );
		
		this.addChild(_swcBtn);
		super.make($node);
		_fireHeightChange();
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _click ( e:Event ):void
	{
		this.dispatchEvent( new Event(_clickEvent, true ) );
	}
	
	// ______________________________________________________________ 
	
	override public function get myDispayThing (  ):DisplayObject
	{
		return _swcBtn;
	}

}

}
