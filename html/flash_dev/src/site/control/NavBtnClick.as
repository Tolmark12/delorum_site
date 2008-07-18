package site.control
{
import flash.display.Sprite;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.model.*;
import site.view.*;

public class NavBtnClick extends SimpleCommand implements ICommand
{

	override public function execute( $note:INotification ):void
	{	
		var newIndex:uint = $note.getBody() as uint;
		
		var navProxy:NavProxy = facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		navProxy.changeSection( newIndex );
	}
}
}
