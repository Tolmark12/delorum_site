package site.view.sections.portfolio_components.column_objects
{

import fl.video.*;
import flash.display.Sprite;
import flash.events.*;
import caurina.transitions.Tweener;

public class Video extends BaseColumnObj implements IColumnObject
{
	private var _player:VideoPlayer  = new VideoPlayer();
	private var _isStopped:Boolean   = true;
	private var _overlayColor:Sprite = new Sprite();
	
	public function Video():void
	{
		super();
		this.buttonMode = true;
		this.addEventListener( MouseEvent.CLICK, _click );
	}
	
	override public function make ( $node:XML ):void
	{
		// Player
		_player.play($node.@src);
		_player.width = Number($node.@w);
		_player.height = Number($node.@h);
		this.addChild(_player);
		_player.addEventListener( VideoEvent.COMPLETE, _playComplete );
		
		// Overlay Color
		_overlayColor.graphics.beginFill(0x333333, 0.6);
		_overlayColor.graphics.drawRect(0,0,this.width, this.height);
		this.addChild(_overlayColor);
		
		_pause();

		super.make($node);
		_fireHeightChange();
	}
	
	// ______________________________________________________________ Video control
	
	private function _play (  ):void
	{
		_player.play();
		Tweener.addTween( _overlayColor, { alpha:0, time:1, transition:"EaseInOutQuint"} );
	}
	
	private function _pause (  ):void
	{
		_player.stop();
		Tweener.addTween( _overlayColor, { alpha:1, time:1, transition:"EaseInOutQuint"} );
	}
	
	// ______________________________________________________________ Event Listeners
	
	private function _playComplete ( e:Event ):void
	{
		trace( "play complete" );
	}
	
	private function _click ( e:Event ):void
	{
		if( _isStopped ) 
		{
			_isStopped = false;
			_player.addEventListener( Event.ENTER_FRAME, _enterFrame );
			_play();
		}
		else
		{
			_isStopped = true;
			_player.removeEventListener( Event.ENTER_FRAME, _enterFrame );
			_pause()
		}
	}
	
	private function _enterFrame ( e:Event ):void
	{
		trace( this + '  :  ' + _player );
	}
	
	// ______________________________________________________________ Destruct
	
	override public function destruct (  ):void
	{
		_player.stop();
		_player.removeEventListener( VideoEvent.COMPLETE, _playComplete );
		_player.removeEventListener( Event.ENTER_FRAME, _enterFrame );
		this.removeChild(_player);

	}

}

}
