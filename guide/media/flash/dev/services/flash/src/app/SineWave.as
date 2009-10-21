package app
{
	import flash.display.*;
	import flash.events.*;
	
	public class SineWave extends Sprite
	{
		private var _speed:Number;
		private var _color:Number;
		
		private var _angle:Number 		= 0;
		private var _yAxis:Number 		= 150;
		private var _amplitude:Number 	= 10;
		private var _frequency:Number	= 10;
		private var _yspeed:Number 		= .15;
		
		public function SineWave($speed:Number, $color:Number)
		{
			_speed = $speed;
			_color = $color;
			
			_init();
		}
		
		private function _init()
		{			
			this.addEventListener(Event.ENTER_FRAME, _drawSine);
		}
		
		private function _drawSine(e:Event):void
		{
			var crestHeight			= _yAxis + Math.sin(_angle)*_amplitude;
			_angle	 				+= _yspeed;
			
			var sprite:SineSprite 	= new SineSprite(_speed, _color, _frequency, crestHeight, _angle);
			this.addChild(sprite);
		}
	}
}