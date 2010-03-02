package app.control
{

import app.view.*;
import app.model.*;
import app.model.vo.*;
import app.AppFacade;	
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import flash.display.Sprite;

public class Startup extends SimpleCommand implements ICommand
{
	override public function execute( $notification:INotification ):void
	{
		// Root Stage
		var Root:Sprite = $notification.getBody() as Sprite;
		
		// Proxies
		var externalDataProxy:ExternalDataProxy 		= new ExternalDataProxy();
		var casestudiesProxy:CaseStudiesProxy 			= new CaseStudiesProxy();
		
		// Mediators
		var casestudiesMediator:CaseStudiesMediator 	= new CaseStudiesMediator( Root );
		
		// Register proxies and mediators
		facade.registerProxy( externalDataProxy );
		facade.registerProxy( casestudiesProxy );
		facade.registerMediator( casestudiesMediator );
				
		// Start it up
		externalDataProxy.getConfigData( Root.stage );
	}
}
}