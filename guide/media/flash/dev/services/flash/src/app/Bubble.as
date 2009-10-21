package app
{
	import flash.display.*;
	import flash.events.*;
	
	public class Bubble extends Sprite
	{	
		private var _speed:Number;
		private var _width:Number;
		private var _height:Number;
		private var _size:Number;
		
		private var _bubble:Bubble_swc = new Bubble_swc();
	
		public function Bubble($speed:Number)
		{
			_speed = $speed;
			
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event):void
		{
			_width 									= stage.stageWidth;
			_height 								= stage.stageHeight;
			
			//_size	= this.scaleX = this.scaleY 	= Math.random()/2;
			_size	= this.scaleX = this.scaleY 	= .25;
			
			this.x 									= 0;
			this.y 									= 0;
			
			this.addChild(_bubble);
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onEnterFrame(e:Event):void
		{
			//this.x += _speed*_size;
			//this.y -= _speed*_size;
			
			this.x 						+= _speed - (Math.random()*2);
			this.y 						-= _speed - (Math.random()*2);
			this.scaleX = this.scaleY 	+= Math.random()/15;
			
			_checkBoundries();
		}
		
		private function _checkBoundries():void
		{
			if(this.x > _width || this.y < (0 - _height))
			{
				this.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				this.removeChild(_bubble);
			}
		}
	}
}