package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.model.PortfolioProxy;
public class LoadProjectXml extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var portfolioProxy:PortfolioProxy = facade.retrieveProxy( PortfolioProxy.NAME ) as PortfolioProxy;
		portfolioProxy.loadProjectXml( portfolioProxy.semiActiveStubIndex, note.getBody() as String );
	}
}
}