package app.view.components
{

import app.model.vo.CaseStudyVo;
import app.view.components.swc.Arrow;
import flash.display.Sprite;
import flash.text.TextFormat;
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
	private var _display:NumberCount_swc			= new NumberCount_swc();
	
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
		_caseStudyHolder.addChild(_description);

		this.addChild(_buttonsHolder);
		this.addChild(_display);
	}
	
	// _____________________________ API
	
	/** 
	*	Create the Quote component
	*	@param		an array of quote VOs
	*/
	public function build ( $caseStudiesList:Array ):void
	{		
		// Text
		_description.x 						= _caseStudies.x + (_caseStudies.width - _description.width)/5;
		_description.y 						= (_caseStudies.y + _caseStudies.height) - _caseStudies.height/4;
		_description.titleTxt.autoSize 		= "center";
		
		_display.x 							= _caseStudies.x + (_caseStudies.width - _display.width)/2;
		_display.y 							= (_caseStudies.y + _caseStudies.height) + 10;
		_description.titleTxt.autoSize 		= "center";
		
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
	}
	
	/** 
	*	Change the quote 
	*/
	public function changeCaseStudy ( $caseStudyVo:CaseStudyVo ):void
	{
		// Activate the buttton
		
		// Text Field
		var formatShapShot:TextFormat  		= _description.titleTxt.getTextFormat();
		_description.titleTxt.text 			= $caseStudyVo.description;
		_description.titleTxt.setTextFormat( formatShapShot );
		
		_display.titleTxt.text = ($caseStudyVo.index + 1) + " of " + _numCaseStudies;
		
		// Case Studies
		Tweener.addTween(_caseStudyHolder, {alpha:0, time:_TIME, delay:_DELAY, transition:_TRANSITION, onComplete:function(){_caseStudies.gotoAndStop($caseStudyVo.image);}});
		Tweener.addTween(_caseStudyHolder, {alpha:1, time:_TIME, delay:_DELAY + .5, transition:_TRANSITION});
		
	}
	
	// _____________________________ Helpers

}
}