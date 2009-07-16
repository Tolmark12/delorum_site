package site.view.sections.portfolio_components.column_objects
{

import flash.display.*;
import flash.events.*;
import flash.geom.ColorTransform;


public class Btn extends BaseColumnObj
{
	private var _swcBtn:ChameleonBtn_swc;
	private var _clickEvent:String;
	
	// Color
	private var _colorTransform:ColorTransform;
	private var _rollOverColor:Number = 0xFFFFFF;
	private var _rollOutColor:Number  = 0xFFFFFF;
	
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
		_swcBtn.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		_swcBtn.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		_clickEvent = $node.@event;
		_colorTransform = _swcBtn.transform.colorTransform;
		
		// possible vars
		_xmlFile = ( String( $node.@xmlFile ).length == 0 )? null : $node.@xmlFile ;
		
		this.addChild(_swcBtn);
		super.make($node);
		_fireHeightChange();
		_fireInitialized();
		_swcBtn.dispatchEvent( new Event( MouseEvent.MOUSE_OUT ) );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _click ( e:Event ):void
	{
		var btnEvent:BtnEvent = new BtnEvent( _clickEvent, true );
		btnEvent.xmlFileIndex = _xmlFile;
		this.dispatchEvent( btnEvent );
	}
	
	private function _onMouseOut ( e:Event ):void
	{
		_colorTransform.color = _rollOutColor;
		_swcBtn.transform.colorTransform = _colorTransform;
	}
	
	private function _onMouseOver ( e:Event ):void
	{
		_colorTransform.color = _rollOutColor;
		_swcBtn.transform.colorTransform = _colorTransform;
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
