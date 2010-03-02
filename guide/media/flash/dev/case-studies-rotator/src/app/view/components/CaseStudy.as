package app.view.components
{

import app.model.vo.CaseStudyVo;
import app.view.components.swc.Arrow;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.*;
import caurina.transitions.Tweener;

public class CaseStudy extends Sprite
{
	private static const _DEFAULT_WIDTH:Number 		= 275;
	
	// Tweener
	private static const _TIME:Number 				= .5;
	private static const _DELAY:Number		 		= 0;
	private static const _TRANSITION:String 		= "easeOutExpo";
	
	private var _numCaseStudies:Number 				= 0;
	
	private var _caseStudyHolder:Sprite				= new Sprite();
	
	// Buttons, Background, Logos
	private var _bg:CaseStudyBackground_swc			= new CaseStudyBackground_swc();
	private var _caseStudies:CaseStudies_swc 		= new CaseStudies_swc();
	private var _buttonsHolder:Sprite				= new Sprite();
	
	// Text
	private var _description:DescriptionText_swc 	= new DescriptionText_swc();
	private var _viewCaseStudy:ViewCaseStudy_swc	= new ViewCaseStudy_swc();
	private var _display:NumberCount_swc			= new NumberCount_swc();
	
	private var _curCaseURL:String;
	
	public function CaseStudy():void
	{
		// init
		_bg.width = _DEFAULT_WIDTH;
		this.x = 0;
		this.y = 0;
		
		// Add children
		this.addChild(_bg);
		this.addChild(_caseStudyHolder);
		
		_caseStudyHolder.addChild(_caseStudies);
		_caseStudyHolder.addChild(_viewCaseStudy);
		_caseStudyHolder.addChild(_description);
		
		_viewCaseStudy.useHandCursor 	= true;
		_viewCaseStudy.buttonMode 		= true;
		_viewCaseStudy.addEventListener(MouseEvent.CLICK, _viewCase);
		
		this.addChild(_buttonsHolder);
		this.addChild(_display);
		
		this.alpha = 0;
	}
	
	// _____________________________ API
	
	/** 
	*	
	*	
	*/
	public function build ( $caseStudiesList:Array ):void
	{		
		// Text			
		_viewCaseStudy.x					= _caseStudies.x + (_caseStudies.width - _viewCaseStudy.width)/2;
		_viewCaseStudy.y					= (_caseStudies.y + _caseStudies.height) - 35;
		_viewCaseStudy.titleTxt.autoSize	= "center";
		
		// Buttons
		var leftArrow:Arrow 				= new Arrow("LEFT");
		var rightArrow:Arrow	 			= new Arrow("RIGHT");
				
		_buttonsHolder.x 					= _caseStudies.x + (_caseStudies.width - _buttonsHolder.width)/2;
		_buttonsHolder.y 					= (_caseStudies.y + _caseStudies.height) + 10;
		
		leftArrow.x 						= -50;
		rightArrow.x						= 50;
		
		_buttonsHolder.addChild(leftArrow);
		_buttonsHolder.addChild(rightArrow);
		
		_numCaseStudies = $caseStudiesList.length;
		
		Tweener.addTween(this, {alpha:1, time:_TIME, delay:(_DELAY + 1), transition:_TRANSITION});	
	}
	
	/** 
	*	 
	*/
	public function changeCaseStudy ( $caseStudyVo:CaseStudyVo ):void
	{		
		_curCaseURL = $caseStudyVo.link;
		
		// Text Field
		_display.titleTxt.text = ($caseStudyVo.index + 1) + " of " + _numCaseStudies;
		
		_display.x 							= _caseStudies.x + (_caseStudies.width - _display.width)/2;
		_display.y 							= (_caseStudies.y + _caseStudies.height) + 10;
		_description.titleTxt.autoSize 		= "center";

		// Case Studies
		Tweener.addTween(_caseStudyHolder, {alpha:0, time:_TIME, delay:_DELAY, transition:_TRANSITION, onComplete:function(){_caseStudies.gotoAndStop($caseStudyVo.image); _loadNewData($caseStudyVo)}});
		Tweener.addTween(_caseStudyHolder, {alpha:1, time:_TIME, delay:_DELAY + .5, transition:_TRANSITION});
	}
	
	private function _loadNewData( $caseStudyVo:CaseStudyVo ):void
	{
		// Text Field
		_description.titleTxt.text 	= $caseStudyVo.description;
		
		_description.x 						= _caseStudies.x + (_caseStudies.width - _description.width)/5;
		_description.y 						= (_caseStudies.y + _caseStudies.height) - _caseStudies.height/4;
		_description.titleTxt.autoSize 		= "center";
	}
	
	private function _viewCase( e:MouseEvent ):void
	{
		navigateToURL(new URLRequest(_curCaseURL), "_self");
	}
}
}