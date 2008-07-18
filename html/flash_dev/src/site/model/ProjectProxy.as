package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;

public class ProjectProxy extends Proxy implements IProxy
{
	public static const NAME:String = "project_proxy";

	public function ProjectProxy( ):void
	{
		super( NAME );
	}

	//sendNotification( MyFacade.SOME_COMMAND, someParameter );
}
}