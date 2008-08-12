package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.view.*;
import site.model.*;
import site.model.vo.*;

public class LoadCss extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var cssFile:String = note.getBody() as String;
		var cssProxy:CssProxy = new CssProxy();
		facade.registerProxy( cssProxy );
		
		cssProxy.loadCss( cssFile );
	}
}
}