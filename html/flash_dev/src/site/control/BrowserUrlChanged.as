package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.SiteFacade;
import site.model.*;
import delorum.errors.ErrorMachine;

public class BrowserUrlChanged extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var newURL:String 				  = note.getBody() as String;
		var navProxy:NavProxy 			  = facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		var portfolioProxy:PortfolioProxy = facade.retrieveProxy( PortfolioProxy.NAME ) as PortfolioProxy;
		
		var pages = newURL.split( "/" ); // ex: /page1/page2/page3
		
		if( pages[1] != navProxy.currentItemUrl ) {
			navProxy.changeSectionBySectionName( pages[1], pages[2] );
		}
		else if( portfolioProxy != null ){
			portfolioProxy.makeStubSemiActiveByName( pages[2] );
		}
	}
}
}