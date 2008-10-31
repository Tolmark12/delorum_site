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

public class HomeMediator extends BaseSection implements IMediator
{	
	public static const NAME:String = "home_section";
	
	private var _mainScreen:MainScreen_swc;
	private var _teaser:Teaser;
	
	public function HomeMediator(  ):void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	 SiteFacade.BROWSER_RESIZE,
		  			 SiteFacade.HOME_TEASER_XML_PARSED ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case  SiteFacade.BROWSER_RESIZE:
				_align();
			break;
			case SiteFacade.HOME_TEASER_XML_PARSED :
				_teaser.teasers = note.getBody() as Array;
				_teaser.begin();
			break;
		}
	}
	
	// ______________________________________________________________ Make
	
	override public function make ():void
	{
		super.make();
		
		_mainScreen = new MainScreen_swc();
		_mainScreen.y = 90;
		_teaser = new Teaser_swc();
		
		_mainScreen.addEventListener( MainScreen.JUMP, _jumpClick );
		_teaser.addEventListener( MouseEvent.CLICK, _teaserClick );
		
		super._baseMc.addChild( _mainScreen );
		super._baseMc.addChild( _teaser );
		_align();
		super.show();
	}
	
	private function _align (  ):void
	{
		_mainScreen.x = StageMediator.stageCenter - _mainScreen.width / 2;
		_teaser.x = StageMediator.stageRight + 2;
		
		var ceiling:uint = 700;
		_teaser.y = ( StageMediator.stageBottom > ceiling )? StageMediator.stageBottom : ceiling ;
		_teaser.y -= _teaser.height + 40
	}
	
	private function _teaserClick ( e:MouseEvent ):void
	{
		sendNotification(SiteFacade.CHANGE_SECTION, "portfolio/Idahoan_Potatoes")
	}
	
	private function _jumpClick ( e:Event ):void
	{
		sendNotification(SiteFacade.CHANGE_SECTION, "portfolio")
	}
	
}
}