package app.control
{

import app.view.*;
import app.model.*;
import app.model.vo.*;
import app.AppFacade;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

public class DataRequests extends SimpleCommand implements ICommand
{
	override public function execute( $notification:INotification ):void
	{
		// Proxies
		var externalDataProxy:ExternalDataProxy 	= facade.retrieveProxy( ExternalDataProxy.NAME ) as ExternalDataProxy;
		var casestudiesProxy:CaseStudiesProxy		= facade.retrieveProxy( CaseStudiesProxy.NAME ) as CaseStudiesProxy;
		
		// Proxy Commands
		switch ( $notification.getName() )
		{
			case AppFacade.CONFIG_DATA_LOADED_AND_PARSED :
				externalDataProxy.loadCaseStudiesData();
			break;
			case AppFacade.CASESTUDIES_DATA_LOADED :
				casestudiesProxy.init( $notification.getBody() as Object );
			break;
		}
	}
}
}