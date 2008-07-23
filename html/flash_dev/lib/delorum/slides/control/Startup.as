package delorum.slides.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import delorum.slides.SlideShowFacade;
import delorum.slides.SlideShow;
import delorum.slides.view.*;
import delorum.slides.model.*;
import delorum.slides.model.vo.*;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var holderMc:SlideShow = note.getBody() as SlideShow;
		
		var autoPlayMediator  :AutoplayMediator;
		var slideShowMediator :DisplayImageMediator;
		var slideShowProxy	  :SlideShowProxy;
		
		// If the main holder is defined...
		if( holderMc != null ) 
		{
			//...create
			autoPlayMediator  = new AutoplayMediator();
			slideShowMediator = new DisplayImageMediator( holderMc );
			slideShowProxy	  = new SlideShowProxy();

			facade.registerMediator	( autoPlayMediator  );
			facade.registerMediator	( slideShowMediator );
			facade.registerProxy	( slideShowProxy    );
		}
		// Else, we are tearing down...
		else
		{
			//...destroy
			sendNotification( SlideShowFacade.STOP_AUTOPLAY );
			
			facade.removeMediator( AutoplayMediator.NAME  );
			facade.removeProxy( SlideShowProxy.NAME		  );
			facade.removeProxy( DisplayImageMediator.NAME );
		}
		
	}
}
}