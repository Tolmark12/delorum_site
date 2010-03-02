package app
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class SineSprite extends Sprite
	{
		private var _speed:Number;
		private var _width:Number;
		private var _height:Number;
		private var _color:Number;
		
		private var _sprite:Sprite		= new Sprite();
		
		private var _angle:Number;
		private var _frequency:Number;
		private var _crestHeight:Number;
		
		private var _xPos:Number;
		private var _yPos:Number;
		
		public function SineSprite($speed:Number, $color:Number, $frequency:Number, $crestHeight:Number, $angle:Number)
		{
			_speed 			= $speed;
			_color 			= $color;
			
			_frequency		= $frequency;
			_crestHeight	= $crestHeight;
			_angle 			+= $angle;
			
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event):void
		{			
			_width 		= stage.stageWidth;
			_height 	= stage.stageHeight;
			
			_xPos 		-= _frequency;
			_yPos 		= _crestHeight;
			
			_sprite.graphics.beginFill(_color);
			_sprite.graphics.drawRect(_xPos, _yPos, 12, _yPos);
			
			if((Math.floor(Math.random() * (25 -  1)) + 1) == 12)
				_populatePlant();
				
			if((Math.floor(Math.random() * (100 -  1)) + 1) == 50)
				_populateRock();
			
			this.addChild(_sprite);
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _populatePlant():void
		{
			var plant:Plant = new Plant();
			plant.x 		= 0 - plant.width;
			plant.y 		= _yPos - (plant.height - 10);
			
			_sprite.addChild(plant);
		}
		
		private function _populateRock():void
		{
			var rock:Rock 	= new Rock();
			rock.x	 		= 0 - rock.width;
			rock.y 			= _yPos - (rock.height - 2);
			
			_sprite.addChild(rock);
		}
		
		private function _onEnterFrame(e:Event):void
		{			
			this.x += _frequency;
			_checkBoundries();
		}
		
		private function _checkBoundries():void
		{
			if(this.x > (_width + this.width))
			{					
				this.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				this.removeChild(_sprite);
			}
			
			//parent.removeChild(this);
		}
	}
}