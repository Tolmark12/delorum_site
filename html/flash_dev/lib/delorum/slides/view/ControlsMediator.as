package delorum.slides.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import delorum.slides.SlideShowFacade;
import delorum.slides.model.vo.*;

public class ControlsMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "controls_mediator";

	public function ControlsMediator():void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return []; //[	SlideShowFacade.NOTIFICATION    ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			/*case SlideShowFacade.NOTIFICATION:
				// CODE
				break;*/
		}
	}
	
}
}