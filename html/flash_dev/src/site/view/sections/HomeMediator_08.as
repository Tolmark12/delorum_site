package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import site.model.vo.*;
import site.SiteFacade;
import site.view.sections.home_08_components.*;
import site.model.vo.Home08_VO;
import flash.events.*;

public class HomeMediator_08 extends BaseSection implements IMediator
{	
	public static const NAME:String = "home_mediator_08";

	public var home:Home = new Home();

	public function HomeMediator_08():void
	{
		super( NAME );
		home.addEventListener( "thumb_click", _onThumbsUpClick, false,0,true );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ SiteFacade.HOME_DATA_PARSED ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SiteFacade.HOME_DATA_PARSED:
				home.build( note.getBody() as Home08_VO );
			break;
		}
	}
	
	override public function make (  ):void
	{
		super.make();
		super._baseMc.addChild( home );
		super.show();
	}
    
	private function _align (  ):void
	{
//		_mainScreen.x = StageMediator.stageCenter - _mainScreen.width / 2;
//		_teaser.x = StageMediator.stageRight + 2;
//    
//		var ceiling:uint = 700;
//		_teaser.y = ( StageMediator.stageBottom > ceiling )? StageMediator.stageBottom : ceiling ;
//		_teaser.y -= _teaser.height + 40
	}
	
	private function _onThumbsUpClick ( e:Event ):void
	{
		sendNotification(SiteFacade.CHANGE_SECTION, "portfolio");
	}

	
}
}