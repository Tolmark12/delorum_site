package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	import app.*;
	
	public class Main extends MovieClip
	{
		private static const _SPEED:Number			= 5;
		private static const _BSPNUM:Number			= 5;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _lureHolder:Sprite				= new Sprite();		
		private var _lure:Lure_swc					= new Lure_swc();
		private var _tailRing:TailRing_swc			= new TailRing_swc();
		private var _lureTail:LureTail_swc			= new LureTail_swc();
		private var _triProng:TriProng_swc			= new TriProng_swc();
		
		public function Main()
		{			
			_init();		
		}
		
		private function _init():void
		{			
			_width 	= stage.stageWidth;
			_height = stage.stageHeight;
			
			var hookTimer:Timer	= new Timer(Math.random()*5000);
			hookTimer.addEventListener(TimerEvent.TIMER, _createHooks);
			hookTimer.start();
			
			_createBubbleSpawnPoints();
			_createBed();
			
			_addChildren();
		}
		
		private function _addChildren():void
		{			
			this.addChild(_lureHolder);
			_lureHolder.addChild(_lure);
			_lureHolder.addChild(_tailRing);
			_lureHolder.addChild(_lureTail);
			_lureHolder.addChild(_triProng);
			
			_positionElements();
		}
		
		private function _positionElements():void
		{
			_lure.x 			= 0;
			_lure.y 			= 0;
			
			_tailRing.x 		= _lure.width - 8;
			_tailRing.y 		= _lure.height - 8;
			_tailRing.rotation 	= -90;
			
			_lureTail.x 		= _tailRing.x +10;
			_lureTail.y 		= _tailRing.y + 2;
			_lureTail.rotation 	= 0;
			
			_triProng.x 		= _lure.width/2 + 65;
			_triProng.y 		= _lure.height - 9;
			
			_lureHolder.x 		= 0;
			_lureHolder.y 		= 0;
		}
		
		private function _createBed():void
		{
			var riverBed:SineWave = new SineWave(_SPEED, 0xFEF4DD);
			this.addChild(riverBed);
		}
		
		private function _createHooks(e:TimerEvent):void
		{
			var hook:Hook = new Hook(_SPEED);
			this.addChildAt(hook, 0);
		}
		
		private function _createBubbleSpawnPoints():void
		{
			var BSPXArray:Array = new Array(160, 180, 190, 380, 370);
			var BSPYArray:Array = new Array(80, 90, 95, 140, 135);
			
			for(var i:Number = 0; i < _BSPNUM; i++)
			{
				var bsp:BubbleSpawnPoint = new BubbleSpawnPoint(_SPEED, BSPXArray[i], BSPYArray[i]);
				this.addChild(bsp);				
			}
		}
	}
}