package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import delorum.loading.ImageLoader;
import site.SiteFacade;
import flash.events.*;
import flash.display.Sprite;
import site.view.StageMediator;
import site.view.sections.home_components.*;
import site.view.sections.about_us_components.*;
import site.model.vo.Jobs_VO;
import site.model.CssProxy;

public class JobsMediator extends BaseSection implements IMediator
{	
	public static const NAME:String = "jobs_mediator";
	
	public function JobsMediator(  ):void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	SiteFacade.BROWSER_RESIZE,
					SiteFacade.JOBS_XML_PARSED, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case  SiteFacade.BROWSER_RESIZE:
				_align();
			break;
			case SiteFacade.JOBS_XML_PARSED :
				_populateText( note.getBody() as Jobs_VO );
			break;
		}
	}
	
	// ______________________________________________________________ Make
	
	override public function make ():void
	{
		super.make();
	}
	
	private function _populateText ( $vo:Jobs_VO ):void
	{
		var currentJobsTxt:BodyText_swc = new BodyText_swc();
		currentJobsTxt.x = 460;
		currentJobsTxt.y = 130
		currentJobsTxt.textWidth = 450;
		currentJobsTxt.parseCss( $vo.css );
		currentJobsTxt.htmlText = $vo.openJobs;
		super._baseMc.addChild( currentJobsTxt) ;
		
		var blurbTxt:BodyText_swc = new BodyText_swc();
		blurbTxt.x = 60;
		blurbTxt.y = 175
		blurbTxt.textWidth = 290;
		blurbTxt.parseCss( $vo.css );
		blurbTxt.htmlText = $vo.generalBlurb;
		blurbTxt.useBitmap = false;
		super._baseMc.addChild( blurbTxt );
		
		super.show();
		
	}
	
	
	private function _align (  ):void
	{
		//_baseMc.x = StageMediator.stageCenter - _baseMc.width / 2;
	}
	
}
}