package site.view.sections.home_08_components
{

import flash.display.*;
import gs.*;
import gs.plugins.*;
import gs.easing.*;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.BlurFilter;
import flash.events.*;
import delorum.utils.EchoMachine;
import delorum.utils.echo;
import delorum.loading.ImageLoader;
import site.view.StageMediator;

public class SlideImage extends Sprite
{
	private var _image:Sprite = new Sprite();
	private var _shadow:Shape = new Shape();
	public var txt:String;
	public static var mod:int = 1;
	public var buttons:Array;
	public var href:String;
	
	public function SlideImage( $path):void
	{
		this.buttonMode = true;
		_draw();
		var imageHolder:Sprite = new Sprite();
		imageHolder.x = -174;
		imageHolder.y = -173;
		_image.addChild(imageHolder);
		var ldr:ImageLoader = new ImageLoader( $path, imageHolder );
		//ldr.addEventListener( IOErrorEvent.IO_ERROR, _onIoError, false,0,true );
		//ldr.addEventListener( Event.COMPLETE, show );
		ldr.loadItem();
		this.visible = false;
	}
	
	private var _hiding:Boolean = false;
	
	public function show ( $rotationMod:Number=1 ):void
	{
		if( !_hiding )
			TweenMax.to(this, 0, {delay:0.4, onComplete:_dropCard });
	}
	
	public function hide (  ):void
	{
		_hiding = true;
		_shadow.visible = false;
		TweenMax.to(_image, 0.4, {x:StageMediator.stageLeft - 500, rotation:Math.random() * 180, onComplete:_makeInvisible } );
	}
	
	private function _dropCard (  ):void
	{
		this.visible = true;
		_shadow.visible = true
		TweenPlugin.activate([BlurFilterPlugin]);
	
	  	// _____________________________ Image

	  	_image.scaleX = 3;
	  	_image.scaleY = 3;
	    _image.rotation = ( 60 +  Math.random() * 90 ) * mod;
		mod *= (Math.random() > 0.89)? 1 : -1 ;
	  	_image.x = 300 * Math.random();
	  	_image.y = -30 + Math.random() * -700;
		_image.rotationY = Math.random() * 110;
		_image.rotationX = Math.random() * 110;
		// Scale and blur
	  	var params:Object = {
	  		scaleX 		: 1,
	  		scaleY 		: 1,
	  		blurFilter	: { blurX:0, blurY:0},
	  		startAt		: { blurFilter	: {blurX:30, blurY:30} }
	  	};
		
		// X, Y & Rotation
	  	var params2:Object = {
	  		x			: 180,
	  		y			: 180,
	  		rotation 	: String(_image.rotation * -1)
	  	}
		
		// Tween
	  	var time:Number = 0.8;
	  	TweenMax.to(_image, time, params);
	  	TweenMax.to(_image, time + 0.2, params2);
		TweenMax.to(_image, time - 0.3, {rotationX:0, rotationY:0, ease:Linear.easeNone});
	
	  	// _____________________________ Shadow
	
	  	_shadow.rotation = _image.rotation;
	  	_shadow.alpha	 = 0.3;
		_shadow.x		 = 300;
		_shadow.y		 = 300;
		
	  	params = {
			scaleX 		: 1,
			scaleY 		: 1,
	  		alpha		: 0.7,
	  		rotation 	: 0,
	  		blurFilter	: {blurX:10, blurY:10},
	  		startAt		: { blurFilter	: {blurX:220, blurY:220} }
	  	};
	
	  	params2 = {
	  		x			: 5,
	  		y			: 5,
	  		rotation 	: String(_image.rotation * -1)
	  	}
	
	  	TweenMax.to(_shadow, time, params);
	  	TweenMax.to(_shadow, time + 0.2, params2);
	}
	
	private function _makeInvisible (  ):void
	{
		_hiding = false;
		this.visible = false;
	}
	
	// _____________________________ Helpers
	
	private function _draw (  ):void
	{
		// Image
		var homeImageBg:HomeImageBg_swc = new HomeImageBg_swc();
		homeImageBg.x = homeImageBg.width/-2;
		homeImageBg.y = homeImageBg.height/-2;
		_image.addChild(homeImageBg);
		
		// Shadow
		_shadow.graphics.beginFill(0x444444);
		_shadow.graphics.drawRect( 0,0,300,300 );
		
		// Add
		this.addChild( _shadow );
		this.addChild( _image  );
	}

}

}