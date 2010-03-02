package app
{
	import flash.display.*;
	
	public class Rock extends Sprite
	{		
		public function Rock()
		{
			_init();
		}
		
		private function _init():Rock_swc
		{
			var rock:Rock_swc = new Rock_swc();
			this.addChild(rock);
			
			rock.scaleX = rock.scaleY = Math.random()*2;
			
			return rock;
		}
	}
}