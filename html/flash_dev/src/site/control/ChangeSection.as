package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.view.*;
import site.model.*;
import site.model.vo.*;

public class ChangeSection extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{		
		var navProxy:NavProxy = facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		navProxy.changeSectionWithSlashedName( note.getBody() as String );
	}
}
}