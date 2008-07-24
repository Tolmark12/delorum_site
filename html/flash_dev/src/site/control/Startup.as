package site.control
{
import flash.display.Sprite;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.model.*;
import site.view.*;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( $note:INotification ):void
	{	
		var rootSprite:Sprite = $note.getBody() as Sprite;
		
		// Create the main display mediator
		var stageMediator:StageMediator = new StageMediator();
		facade.registerMediator( stageMediator );
		stageMediator.build( rootSprite );
		stageMediator.initBrowserConnection();
		
		// Create the navigation mediator
		var navMediator:NavMediator = new NavMediator();
		facade.registerMediator( navMediator );
		// Send the nav mediator a reference to the logo and the nav holder sprite
		navMediator.logoSprite = stageMediator.logoSprite;
		navMediator.navSprite  = stageMediator.navSprite;
		
		// Create the color scheme proxy, and load the color schemes
		var colorProxy:ColorSchemeProxy = new ColorSchemeProxy();
		facade.registerProxy( colorProxy );
		colorProxy.loadXml( rootSprite );
		
		// Create the main proxy, and load the xml
		var navProxy:NavProxy = new NavProxy();
		facade.registerProxy( navProxy );
		navProxy.loadXml( rootSprite   );
		
		stageMediator.defaultBg = navProxy.defaultBgColor;
	}
}
}
