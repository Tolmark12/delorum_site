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
import site.view.sections.about_us_09_components.*;
import site.model.vo.AboutUsBlurb_VO;

public class AboutUsMediator_09 extends BaseSection implements IMediator
{	
	public static const NAME:String = "about_us_mediator_09";
	
	private var _pageManager:AboutPageManager = new AboutPageManager();
	
	public function AboutUsMediator_09(  ):void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	SiteFacade.BROWSER_RESIZE,
					SiteFacade.ABOUT_US_09_XML_PARSED, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case  SiteFacade.BROWSER_RESIZE:
			break;
			case SiteFacade.ABOUT_US_09_XML_PARSED :
				trace( _pageManager.parent );
			break;
		}
	}
	
	// ______________________________________________________________ Make
	
	override public function make ():void
	{
		super.make();
		super._baseMc.addChild(_pageManager);
	}
	
	private function _populateBlurbs ( $blurbs:Array ):void
	{
		super.show();
	}
	
	
	private function _align (  ):void
	{
		_baseMc.x = StageMediator.stageCenter - _baseMc.width / 2;
	}
	
}
}