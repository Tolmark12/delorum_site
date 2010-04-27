package site.view.sections.home_08_components
{

import flash.display.Sprite;
import site.model.vo.Home08_VO;
import flash.events.*;
import flash.geom.ColorTransform;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import delorum.loading.ImageLoader;
import caurina.transitions.Tweener;

public class Home extends Sprite
{
	private var _slides:HomeSlideShow;
	private var _leftBlurb:BodyText_swc		= new BodyText_swc();
	private var _rightBlurb:BodyText_swc 	= new BodyText_swc();
	private var _leftBtn:ChameleonBtn_swc	= new ChameleonBtn_swc();
	private var _rightBtn:ChameleonBtn_swc	= new ChameleonBtn_swc();
	private var _imageHolder:Sprite			= new Sprite();
	public function Home():void
	{
		this.visible = false;
		this.addChild(_leftBlurb);
		this.addChild(_rightBlurb);
	}
	
	// _____________________________ API
	
	public function build ( $vo:Home08_VO ):void
	{
		// Slides
		_slides = new HomeSlideShow();
		_slides.x = 20;
		_slides.y = 80;
		_slides.init( $vo.slides, $vo.slideCss );
		this.addChild(_slides);
		
		var baseline:Number = 500;
		
		// Blurbs
		_leftBlurb.parseCss( $vo.blurbCss );
		_leftBlurb.textWidth = 330;
		_leftBlurb.htmlText = $vo.getHtmlText( "left" );
		_leftBlurb.y = baseline;
		_leftBlurb.x = 20;
		
		_rightBlurb.parseCss( $vo.blurbCss );
		_rightBlurb.textWidth = 290;
		_rightBlurb.htmlText = $vo.getHtmlText( "right" );
		_rightBlurb.y = baseline;
		_rightBlurb.x = 395;
		
		// Buttons below the text
		_addButtons( $vo );
		
		// Lower right image
		var ldr:ImageLoader = new ImageLoader( $vo.lowerRightImage, _imageHolder );
		ldr.addEventListener( Event.COMPLETE, _handleImageLoaded );
		ldr.loadItem();
		_imageHolder.buttonMode = true;
		_imageHolder.addEventListener( MouseEvent.CLICK, _onImageClick, false,0,true );
		
		// Make visible
		this.visible = true;
	}
	
	private function _addButtons ( $vo:Home08_VO ):void
	{
		_rightBtn.text 	= $vo.xml.blurbs.rightBlurb.btn.@text;
		_rightBtn.icon 	= $vo.xml.blurbs.rightBlurb.btn.@icon;
		_rightBtn.url	= $vo.xml.blurbs.rightBlurb.btn.@url;
		_rightBtn.y 	= _rightBlurb.y + _rightBlurb.height + 10;
		_rightBtn.x 	= _rightBlurb.x;
		_rightBtn.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		_rightBtn.titleTxt.x = 0;
		_rightBtn.icons.x = _rightBtn.titleTxt.width;
		
		var newColorTransform:ColorTransform = _rightBtn.icons.transform.colorTransform;
		newColorTransform.color = 0xD65C23;
		_rightBtn.icons.transform.colorTransform = newColorTransform;
		
		newColorTransform = _rightBtn.titleTxt.transform.colorTransform;
		newColorTransform.color = 0x636565;
		_rightBtn.titleTxt.transform.colorTransform = newColorTransform;
		
		//_rightBtn.buttonMode = false;
		//_rightBtn.mouseEnabled = false;
		_rightBtn.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		_rightBtn.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		_rightBtn.dispatchEvent(new Event(MouseEvent.MOUSE_OUT));
		
		_leftBtn.text 	= $vo.xml.blurbs.leftBlurb.btn.@text;
		_leftBtn.icon 	= $vo.xml.blurbs.leftBlurb.btn.@icon;
		_leftBtn.url	= $vo.xml.blurbs.leftBlurb.btn.@url;
		_leftBtn.y 	= _leftBlurb.y + _leftBlurb.height + 10;
		_leftBtn.x 	= _leftBlurb.x;
		_leftBtn.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		_leftBtn.titleTxt.x = 0;
		_leftBtn.icons.x = _leftBtn.titleTxt.width;
		
		newColorTransform = _leftBtn.icons.transform.colorTransform;
		newColorTransform.color = 0xD65C23;
		_leftBtn.icons.transform.colorTransform = newColorTransform;
		
		newColorTransform = _leftBtn.titleTxt.transform.colorTransform;
		newColorTransform.color = 0x636565;
		_leftBtn.titleTxt.transform.colorTransform = newColorTransform;
		
		_leftBtn.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		_leftBtn.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		_leftBtn.dispatchEvent(new Event(MouseEvent.MOUSE_OUT));
		
		this.addChild(_rightBtn);
		this.addChild(_leftBtn);
	}
	
	private function _onClick ( e:Event ):void
	{
		var btn:ChameleonBtn_swc = e.currentTarget as ChameleonBtn_swc;
		var window:String = ( btn.url.indexOf("http:") == -1 )? '_self' : '_blank' ;
		navigateToURL(new URLRequest( btn.url ), window);
	}
	
	private function _onMouseOver ( e:Event ):void {
		( e.currentTarget as Sprite ).alpha = 1;
	}
	
	private function _onMouseOut ( e:Event ):void {
		(e.currentTarget as Sprite).alpha = 0.8;
	}
	
	private function _handleImageLoaded ( e:Event ):void {
		this.addChild(_imageHolder);
		_imageHolder.x = 735;
		_imageHolder.y = 500;
		_imageHolder.alpha = 0;
		Tweener.addTween( _imageHolder, { alpha:1, time:1, transition:"EaseInOutQuint"} );
	}
	
	private function _onImageClick ( e:Event ):void {
		trace( _rightBtn.url  );
		navigateToURL(new URLRequest( _rightBtn.url ), "_blank" );
	}

}

}