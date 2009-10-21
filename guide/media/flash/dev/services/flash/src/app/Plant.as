package app
{
	import flash.display.*;
	
	public class Plant extends Sprite
	{		
		public function Plant()
		{
			_init();
		}
		
		private function _init():Plant_swc
		{
			var plant:Plant_swc = new Plant_swc();
			this.addChild(plant);
			
			plant.gotoAndStop(Math.floor(Math.random() * (plant.totalFrames -  1)) + 1);
			
			return plant;
		}
	}
}