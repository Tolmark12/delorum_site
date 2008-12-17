package swc_components
{

import flash.display.MovieClip;
import caurina.transitions.Tweener;
import flash.events.*;
import site.view.StageMediator;

public class ContactCard extends MovieClip
{
	private static const _CARD_Y_IN:Number = 48;
	private static const _CARD_Y_OUT:Number = 60;
	public static const CLOSE:String = "close";
	private var _cardBg:MovieClip;
	private var _hiderMc:MovieClip;
	private var _closeBtn:MovieClip;
	
	public function ContactCard():void
	{
		_cardBg = this.getChildByName("cardBg") as MovieClip;
		_hiderMc = this.getChildByName("hider") as MovieClip;
		//FIXME: I must have accidentally deleted the close button some how...
		//_closeBtn = _cardBg.getChildByName("closeBtn") as MovieClip;
		//_closeBtn.buttonMode = true;
		_hiderMc.blendMode = "multiply";
		init();
	}
	
	public function init (  ):void
	{
		_cardBg.y = _CARD_Y_IN
		this.visible = false;
		this.alpha = 0;
		_hiderMc.addEventListener( MouseEvent.CLICK, _closeClick );
		//_closeBtn.addEventListener( MouseEvent.CLICK, _closeClick );
	}
	
	public function show ( ):void
	{
		_hiderMc.alpha = 0;
		_hiderMc.x = StageMediator.stageLeft;
		_hiderMc.y = 0;
		_hiderMc.width = StageMediator.stageWidth;
		_hiderMc.height = StageMediator.stageHeight;
		_cardBg.x = StageMediator.stageRight - _cardBg.width - 50;
		this.visible = true;
		Tweener.addTween( _hiderMc, { alpha:1, time:1, transition:"EaseInOutQuint"} );
		Tweener.addTween( this, { alpha:1, time:0.6, transition:"EaseInOutQuint"} );
		Tweener.addTween( _cardBg, { y:_CARD_Y_OUT, time:0.6, transition:"EaseInOutQuint"} );
	}
	
	public function hide (  ):void
	{
		Tweener.addTween( this, { alpha:0, time:0.3, transition:"EaseInOutQuint", onComplete:_hide} );
		Tweener.addTween( _cardBg, { y:_CARD_Y_IN, time:0.6, transition:"EaseInOutQuint"} );
	}
	
	private function _hide (  ):void
	{
//		this.scaleY = 0
//		this.alpha = 1;
		this.visible = false;
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _closeClick ( e:Event ):void
	{
		this.dispatchEvent( new Event(CLOSE) );
	}
}

}