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
	private var _currentJobsTxt:BodyText_swc;
	
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
		_currentJobsTxt = new BodyText_swc();
		//_currentJobsTxt.parseCss( CssProxy.getCss( "default" ) );
		trace( CssProxy.getCss("default") );
		_currentJobsTxt.text = $vo.openJobs;
		super._baseMc.addChild(_currentJobsTxt);
		super.show();
		//var len:uint = $blurbs.length;
		//for ( var i:uint=0; i<len; i++ ) 
		//{
		//	var vo:AboutUsBlurb_VO = $blurbs[i];
		//	var blurb:AboutUsBlurb_swc = new AboutUsBlurb_swc();
		//	blurb.x = i * 300;
		//	blurb.y = 100;
		//	blurb.title = vo.title;
		//	blurb.number = vo.number;
		//	blurb.setText( vo.htmlText, AboutUsBlurb_VO.css );
		//	_baseMc.addChild(blurb);
		//}
		//
		//super.show();
		//_align();
		//sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED );
		
	}
	
	
	private function _align (  ):void
	{
		//_baseMc.x = StageMediator.stageCenter - _baseMc.width / 2;
	}
	
}
}