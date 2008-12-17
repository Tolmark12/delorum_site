package site.view.sections.portfolio_components.column_objects
{

import flash.display.*;
import site.view.sections.portfolio_components.ProjectStub;
import flash.events.*;

public class BaseColumnObj extends Sprite implements IColumnObject
{
	// Events
	public static const INITIALIZED:String = "initializasdfed";
	
	public function BaseColumnObj():void
	{
		
	}
	
	public function make ( $node:XML ):void { 
		var xMod:Number = ( String( $node.@xMod ).length != 0 )? Number( $node.@xMod ): 0 ;
		var yMod:Number = ( String( $node.@yMod ).length != 0 )? Number( $node.@yMod ): 0 ;
		myDispayThing.x += xMod;
		myDispayThing.y += yMod;
	};
	
	public function setWidth ( $width:Number ):void{ };
	
	protected function _fireHeightChange()
	{
		this.dispatchEvent( new Event( ProjectStub.CONTENT_HEIGHT_CHANGED, true) );
	}
	
	protected function _fireInitialized (  ):void
	{
		this.dispatchEvent( new Event( INITIALIZED, true) );
	}
	
	
	public function destruct (  ):void
	{
		
	}
	
	// ______________________________________________________________ Getters Settesr
	
	public function get myWidth (  ):Number{ return this.width; };
	public function get myHeight (  ):Number{ return this.height; };
	public function get myDispayThing (  ):DisplayObject
	{
		return this;
	}
}

}