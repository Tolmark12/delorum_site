package 
{

import flash.display.Sprite;
import flash.utils.*;
import flash.events.*;
import flash.geom.Point;
import caurina.transitions.Tweener;
import com.everydayflash.util.Rotator;

public class Stars extends Sprite
{	
	private var _WIDTH:Number 							= 0;
	private var _HEIGHT:Number 							= 0;
	
	private static const _TIME:Number 					= 1;
	private static const _DELAY:Number 					= 0;
	private static const _TRANSITION:String 			= "easeOutExpo";
	
	private static const _STARNUM:Number 				= 50;
	private static const _TIMERTIME:Number 				= 10000;
	private static const _SCALE:Number					= .25;
	
	private var _trees:Trees_swc						= new Trees_swc();
	private var _caseStudiesText:CaseStudiesText_swc 	= new CaseStudiesText_swc();
	
	public function Stars():void
	{
		_WIDTH = stage.stageWidth;
		_HEIGHT = stage.stageHeight/2;
		
		_init();
	}
	
	private function _init():void
	{		
		for(var i:Number = 0; i < _STARNUM; i++)
		{
			var star:Star_swc 	= new Star_swc();
			this.addChild(star);
			
			star.x 						= Math.random()*_WIDTH;
			star.y 						= Math.random()*_HEIGHT;
			
			star.alpha 					= Math.random();
			star.scaleX = star.scaleY 	= _SCALE;
			
			_glow(star);
			star.addEventListener(Event.ENTER_FRAME, _rotate);
		}
		
		this.addChild(_trees);
		this.addChild(_caseStudiesText);
		
		_trees.x 				= 0;
		_trees.y 				= _HEIGHT*2 - _trees.height;
		
		_caseStudiesText.x 		= 30;
		_caseStudiesText.y 		= 125;
		
		var timer:Timer	= new Timer(_TIMERTIME);
		timer.addEventListener(TimerEvent.TIMER, _shootStar);
		timer.start();
	}
	
	private function _glow($star:Star_swc):void
	{
		Tweener.addTween($star, {alpha:Math.random(), time:_TIME*3, delay:_DELAY, transition:"linear", onComplete:function(){_glow(this)}});
	}
	
	private function _rotate(e:Event):void
	{
		var star = e.currentTarget;
		
		var rotator:Rotator = new Rotator(star, new Point(_WIDTH/2, _HEIGHT*5));
		rotator.rotation -= .025;
		
		_checkPosition(star);		
	}
	
	private function _checkPosition($star:Star_swc)
	{		
		if($star.x < 0)
		{
			$star.x = _WIDTH;
			$star.y = Math.random()*(_HEIGHT*1.5); 
		}
	}
	
	private function _shootStar(e:TimerEvent):void
	{
		var shootingStar:Star_swc = new Star_swc();
		this.addChildAt(shootingStar, 0);
		
		var startPos:Number							= 0;
		var endPos:Number							= 0;
		
		if(Math.round(Math.random()) == 1)
		{
			startPos		 						= 0;
			endPos		 							= _WIDTH;
		}else{
			startPos		 						= _WIDTH;
			endPos		 							= 0;
		}
		
		shootingStar.x 								= startPos;
		shootingStar.y 								= Math.random()*_HEIGHT/3;
		
		shootingStar.alpha 							= .75;
		shootingStar.scaleX = shootingStar.scaleY 	= _SCALE;
		
		Tweener.addTween(shootingStar, {alpha:0, x:endPos, y:(this.y + 75), time:_TIME*2, delay:_DELAY, transition:_TRANSITION})
		
		if(shootingStar.alpha == 0)
			this.removeChild(shootingStar);
	}
}
}