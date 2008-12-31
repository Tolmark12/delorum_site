package site.view.sections.portfolio_components.column_objects
{

import flash.display.*;
import flash.events.*;
public class Btn extends BaseColumnObj
{
	private var _swcBtn:ChameleonBtn_swc;
	private var _clickEvent:String;
	
	
	// possible vars
	private var _xmlFile:String;
	
	public function Btn():void
	{
		
	}
	
	override public function make ( $node:XML ):void
	{
		_swcBtn = new ChameleonBtn_swc();
		_swcBtn.text = $node.@text;
		_swcBtn.icon = $node.@icon;
		_swcBtn.useHandCursor = true;
		_swcBtn.addEventListener( MouseEvent.CLICK, _click, false,0,true );
		_clickEvent = $node.@event;
		
		// possible vars
		_xmlFile = ( String( $node.@xmlFile ).length == 0 )? null : $node.@xmlFile ;
		
		this.addChild(_swcBtn);
		super.make($node);
		_fireHeightChange();
		_fireInitialized();
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _click ( e:Event ):void
	{
		var btnEvent:BtnEvent = new BtnEvent( _clickEvent, true );
		btnEvent.xmlFileIndex = _xmlFile;
		this.dispatchEvent( btnEvent );
	}
	
	// ______________________________________________________________ 
	
	override public function get myDispayThing (  ):DisplayObject
	{
		return _swcBtn;
	}
	
	// ______________________________________________________________ Destruct
	
	override public function destruct (  ):void
	{
		super.destruct();
		_swcBtn.removeEventListener( MouseEvent.CLICK, _click );
	}

}

}
