package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.view.*;
import site.model.*;
import site.model.vo.*;

public class CssLoaded extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{		
		//var someProxy:SomeProxy = facade.retrieveProxy( SomeProxy.NAME ) as SomeProxy;
		var portfolioProxy:PortfolioProxy = facade.retrieveProxy( PortfolioProxy.NAME ) as PortfolioProxy;
		portfolioProxy.parsePortfolioXml();
	}
}
}