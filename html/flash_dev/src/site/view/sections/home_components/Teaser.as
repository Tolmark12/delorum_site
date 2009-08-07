package site.view.sections.home_components
{

import flash.display.*;
import site.model.vo.HomeTeaser_VO;
import delorum.loading.ImageLoader;
import flash.text.*;
import flash.utils.Timer;
import flash.events.TimerEvent;

public class Teaser extends MovieClip
{
	public var teasers:Array;
	private var _teaserIndex:uint = 0;
	
	// On the stage of the movieclip
	private var _arrowBtn:MovieClip;
	private var _bodyTxt:TextField;
	private var _h1Text:TextField;
	private var _linkText:TextField;
	
	// These will eventually be deleted as we make this a rotating system
	private var _leftCard:TeaserImageCard_swc;
	private var _rightCard:TeaserImageCard_swc;
	
	public function Teaser():void
	{
		this.mouseChildren = false;
		this.buttonMode = true;
		_arrowBtn 	= this.getChildByName("arrowBtn") as MovieClip;
		_h1Text 	= this.getChildByName("h1Txt") as TextField;
		_bodyTxt 	= this.getChildByName("bodyTxt") as TextField;
		_linkText	= this.getChildByName("linkTxt") as TextField;
	}
	
	public function begin (  ):void
	{
		_showNextTeaser(null);
		//_startTimer();
	}
	
	private function _showNextTeaser ( e:TimerEvent ):void
	{
		var vo:HomeTeaser_VO = teasers[ _teaserIndex ];
		
		_createCards(vo);

		
		// Text
		var hf:TextFormat = _h1Text.getTextFormat();
		var bf:TextFormat = _bodyTxt.getTextFormat();
		var lf:TextFormat = _linkText.getTextFormat()
		
		_h1Text.text = vo.headLine;
		_bodyTxt.htmlText = vo.body;
		_linkText.text = vo.link;
		_arrowBtn.x = _linkText.x + _linkText.textWidth + 4;
		
		_h1Text.setTextFormat( hf );
		_bodyTxt.setTextFormat( bf );
		_linkText.setTextFormat( lf );
	}
	
	// _____________________________ Create
	private function _createCards ( $vo:HomeTeaser_VO ):void
	{
		if( _leftCard == null ) {
			// Cards
			_leftCard = new TeaserImageCard_swc();
			_rightCard = new TeaserImageCard_swc();
			_leftCard.x = -600;
			_leftCard.y = 0;
			_rightCard.x = -840;
			_rightCard.y = 0;

			var rightHolder:Sprite = new Sprite();
			var leftHolder:Sprite  = new Sprite();

			rightHolder.x = rightHolder.y = leftHolder.x = leftHolder.y = 10;

			_rightCard.addChild(rightHolder);
			_leftCard.addChild(leftHolder);
			
			var ldr1:ImageLoader = new ImageLoader( $vo.imageRightPath, rightHolder );
			ldr1.loadItem();
			var ldr2:ImageLoader = new ImageLoader( $vo.imageLeftPath, leftHolder );
			ldr2.loadItem();

			this.addChild(_leftCard);
			this.addChild(_rightCard);
		}
	}
	
	
	// _____________________________ Timer
	
	private function _startTimer (  ):void
	{
		var myTimer:Timer = new Timer(5000, 2);
		myTimer.addEventListener("timer", _showNextTeaser);
		myTimer.start();
	}

}

}