package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.view.*;

public class UnloadCurrentSection extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
		stageMediator.unloadCurrentSection();
	}
}
}