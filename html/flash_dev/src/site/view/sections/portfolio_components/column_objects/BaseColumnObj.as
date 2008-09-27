package site.view.sections.portfolio_components.column_objects
{

import flash.display.Sprite;
import site.view.sections.portfolio_components.ProjectStub;
import flash.events.*;

public class BaseColumnObj extends Sprite implements IColumnObject
{
	public function BaseColumnObj():void
	{
		
	}
	
	public function make ( $node:XML ):void { };
	public function setWidth ( $width:Number ):void{ };
	
	protected function _fireHeightChange()
	{
		this.dispatchEvent( new Event( ProjectStub.CONTENT_HEIGHT_CHANGED, true) );
	}
	
	public function get myWidth (  ):Number{ return this.width; };
}

}