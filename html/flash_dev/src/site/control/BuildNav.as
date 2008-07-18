package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.view.*;
public class BuildNav extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		// Init Connection between browser and flash
		var urlMediator:BrowserUrlMediator = new BrowserUrlMediator();
		facade.registerMediator( urlMediator );
	}
}
}