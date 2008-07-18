package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.SiteFacade;
import site.model.*;

public class ProjectStubClick extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		// get array Id
		var arrayId:uint = note.getBody() as uint;
		
		var navProxy:NavProxy 			  = facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		var portfolioProxy:PortfolioProxy = facade.retrieveProxy( PortfolioProxy.NAME ) as PortfolioProxy;
		
		// Let proxy know that user has clicked the nav item 
		portfolioProxy.makeStubSemiActive( arrayId );
		navProxy.changeUrlPath( portfolioProxy.currentProjectUrl, 1 );
	}
}
}