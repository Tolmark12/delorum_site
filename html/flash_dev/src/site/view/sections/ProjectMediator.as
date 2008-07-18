package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;

public class ProjectMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "project_mediator";

	public function ProjectMediator():void
	{
		super( NAME );
   	}

	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return []; //[	ApplicationFacade.SOME_EVENT    ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			/*case ApplicationFacade.SOME_EVENT:
				// CODE
				break;*/
		}
	}
	
}
}