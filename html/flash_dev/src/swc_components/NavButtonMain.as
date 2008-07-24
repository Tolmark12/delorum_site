package swc_components
{
import DelorumSite;
import gs.TweenLite;
import flash.display.*;
import flash.text.TextField;
import flash.events.*;

public class NavButtonMain extends MovieClip
{
	private var _titleTxt:TextField;
	private var _index:uint;
	private var _selected:Boolean = false;
	private var _currentState:String = "COLOR_UP";
	
	public static var COLOR_UP:uint;
	public static var COLOR_HOVER:uint;
	public static var COLOR_ACTIVE:uint;
	
	public function NavButtonMain():void
	{
		_titleTxt = this.getChildByName("titleTxt") as TextField;
		_titleTxt.autoSize = "left";
		this.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver);
		this.addEventListener( MouseEvent.MOUSE_OUT,  _mouseOut );
		this.buttonMode = true;
	}
	
	public function drawHitArea (  ):void
	{
		var hitAreaSpr:Sprite = new Sprite();
		this.addChild( hitAreaSpr );
		hitAreaSpr.alpha = 0;
		
		hitAreaSpr.graphics.beginFill(0xFF0000);
		hitAreaSpr.graphics.drawRect(0,0,textWidth + 4, 30);
	}
	
	/** 
	*	Make this them active nav button
	*/
	public function select (  ):void
	{
		_selected = true;
		_currentState = "COLOR_ACTIVE";
		TweenLite.to(this, 0.1, { tint:COLOR_ACTIVE });
	}
	
	/** 
	*	Make this inactive
	*/
	public function deselct (  ):void
	{
		_selected = false;
		_currentState = "COLOR_UP";
		TweenLite.to(this, 0.3, { tint:COLOR_UP });
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _mouseOver ( e:Event ):void
	{
		if( !_selected ) {
			_currentState = "COLOR_HOVER";
			TweenLite.to(this, 0.2, { tint:COLOR_HOVER});
		}
	}
	
	private function _mouseOut ( e:Event ):void
	{
		if( !_selected ) {
			_currentState = "COLOR_UP";
			TweenLite.to(this, 0.2, { tint:COLOR_UP });
		}
	}
	
	public function updateColor (  ):void
	{
		TweenLite.to(this, 0.2, { tint:NavButtonMain[_currentState] });
	}

	// ______________________________________________________________ Getters / Setters
	
	public function set title ( $str:String ):void{ _titleTxt.text = $str };
	public function set index ( $val:uint ):void { _index = $val; };
	public function get index ():uint 			 { return _index; };
	public function get title	  (  ):String { return _titleTxt.text; 		};
	public function get textWidth (  ):uint   { return _titleTxt.textWidth; };
}

}