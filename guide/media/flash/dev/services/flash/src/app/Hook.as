package app
{
	import flash.display.*;
	import flash.events.*;
	
	public class Hook extends Sprite
	{	
		private var _speed:Number;
		private var _width:Number;
		private var _height:Number;
		private var _size:Number;
		
		private var _hook:FishingHook_swc = new FishingHook_swc();
		
		public function Hook($speed:Number)
		{	
			_speed = $speed;
			
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event):void
		{			
			_width 		= stage.stageWidth;
			_height 	= stage.stageHeight;
			
			_size = this.scaleX = this.scaleY 	= (Math.random() + .25);
			
			this.x								= 0;
			this.y								= 0;
			//this.alpha 							= _size - .15;
			
			if((Math.round(Math.random())%2) == 0)
			{
				this.scaleX = _size*1;
			}else{
				this.scaleX = _size*-1;
			}
			
			this.addChild(_hook);
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onEnterFrame(e:Event):void
		{			
			this.x += _speed*this.scaleY;
			_checkBoundries();
		}
		
		private function _checkBoundries():void
		{
			if(this.x > _width)
			{
				this.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				this.removeChild(_hook);
			}
			
			//parent.removeChild(this);
		}
	}
}