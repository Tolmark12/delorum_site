package app.view
{

import app.AppFacade;
import app.model.vo.*;
import app.view.components.*;
import app.view.components.events.*;
import app.view.components.CaseStudy;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import flash.events.*;
import flash.display.Sprite;

public class CaseStudiesMediator extends Mediator implements IMediator
{	
	public static const NAME:String 	= "casestudies_mediator";
	
	private var _caseStudy:CaseStudy	= new CaseStudy();
	
	public function CaseStudiesMediator( $stage:Sprite ):void
	{
		super( NAME );
		
		$stage.addChild(_caseStudy);
		
		_caseStudy.addEventListener(CaseStudyEvent.CASESTUDY_CLICKED, _onCaseStudyClick);
		_caseStudy.addEventListener(CaseStudyEvent.NEXT, _onCaseStudyClick);
		_caseStudy.addEventListener(CaseStudyEvent.PREVIOUS, _onCaseStudyClick);
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.CASESTUDIES_PARSED,
		 		 AppFacade.ACTIVATE_CASESTUDY ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.CASESTUDIES_PARSED :
				_caseStudy.build( note.getBody() as Array);
			break;
			case AppFacade.ACTIVATE_CASESTUDY :
				_caseStudy.changeCaseStudy( note.getBody() as CaseStudyVo);
			break;
		}
	}
	
	// _____________________________ Events
	
	private function _onCaseStudyClick ( e:CaseStudyEvent ):void
	{		
		switch(e.type)
		{
			case "casestudy_clicked" :
				sendNotification( AppFacade.CASESTUDY_CLICKED, e.index );
			break;
			case "previous" :
				sendNotification( AppFacade.PREVIOUS, e.index );
			break;
			case "next" :
				sendNotification( AppFacade.NEXT, e.index );
			break;
		}
		
	}
	
}
}