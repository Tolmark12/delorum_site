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
import site.model.vo.AboutUsBlurb_VO;

public class AboutUsMediator extends BaseSection implements IMediator
{	
	public static const NAME:String = "about_us_section";
	public function AboutUsMediator(  ):void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	SiteFacade.BROWSER_RESIZE,
					SiteFacade.ABOUT_US_XML_PARSED, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case  SiteFacade.BROWSER_RESIZE:
				_align();
			break;
			case SiteFacade.ABOUT_US_XML_PARSED :
				_populateBlurbs( note.getBody() as Array );
			break;
		}
	}
	
	// ______________________________________________________________ Make
	
	override public function make ():void
	{
		super.make();
	}
	
	private function _populateBlurbs ( $blurbs:Array ):void
	{
		var len:uint = $blurbs.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var vo:AboutUsBlurb_VO = $blurbs[i];
			var blurb:AboutUsBlurb_swc = new AboutUsBlurb_swc();
			blurb.x = i * 300;
			blurb.y = 100;
			blurb.title = vo.title;
			blurb.number = vo.number;
			blurb.setText( vo.htmlText, AboutUsBlurb_VO.css );
			_baseMc.addChild(blurb);
		}
		
		super.show();
		_align();
		sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED );
		
	}
	
	
	private function _align (  ):void
	{
		_baseMc.x = StageMediator.stageCenter - _baseMc.width / 2;
	}
	
}
}