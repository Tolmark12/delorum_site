package app
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class BubbleSpawnPoint extends Sprite
	{
		private var _speed:Number;
		
		public function BubbleSpawnPoint($speed:Number, $xPos:Number, $yPos:Number)
		{
			_speed = $speed;
			
			this.x = $xPos;
			this.y = $yPos;
			
			var bubbleTimer:Timer = new Timer(Math.random()*1000);
			bubbleTimer.addEventListener(TimerEvent.TIMER, _createBubble);
			bubbleTimer.start();
		}
		
		private function _createBubble(e:TimerEvent):void
		{
			var bubble:Bubble = new Bubble(_speed);			
			this.addChild(bubble);
		}
	}
}