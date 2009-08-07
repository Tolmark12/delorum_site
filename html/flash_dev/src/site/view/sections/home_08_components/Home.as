package site.view.sections.home_08_components
{

import flash.display.Sprite;
import site.model.vo.Home08_VO;

public class Home extends Sprite
{
	private var _slides:HomeSlideShow;
	private var _leftBlurb:BodyText_swc		= new BodyText_swc();
	private var _rightBlurb:BodyText_swc 	= new BodyText_swc();
	private var _thumbs:ThumbsBtn_swc 		= new ThumbsBtn_swc();	
	
	public function Home():void
	{
		this.visible = false;
		this.addChild(_leftBlurb);
		this.addChild(_rightBlurb);
		this.addChild(_thumbs);
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
		_rightBlurb.x = 400;
		
		// Thumb Btn
		_thumbs.x = 690;
		_thumbs.y = baseline - 25;
		this.visible = true;
	}

}

}