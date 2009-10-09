package app.control
{
	
import app.view.*;
import app.model.*;
import app.model.vo.*;
import app.AppFacade;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

public class Clicks extends SimpleCommand implements ICommand
{
	override public function execute( note:INotification ):void
	{
		var casestudyProxy:CaseStudiesProxy = facade.retrieveProxy( CaseStudiesProxy.NAME ) as CaseStudiesProxy;
		
		switch (note.getName() as String)
		{
			case AppFacade.CASESTUDY_CLICKED :
				casestudyProxy.activateCaseStudyByIndex( note.getBody() as Number );
			break;
			case AppFacade.PREVIOUS :
				casestudyProxy.previous(  );
			break;
			case AppFacade.NEXT :
				casestudyProxy.next(  );
			break;
		}
	}
}
}