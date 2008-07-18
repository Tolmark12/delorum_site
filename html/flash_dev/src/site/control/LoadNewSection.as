package site.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import site.model.vo.NavItem_VO;
import site.model.*;
import site.view.*;
import site.SiteFacade;
import site.view.sections.*;

public class LoadNewSection extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var navProxy:NavProxy 					= facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		var colorProxy:ColorSchemeProxy 		= facade.retrieveProxy( ColorSchemeProxy.NAME ) as ColorSchemeProxy;
		var stageMediator:StageMediator			= facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
		var navMediator:NavMediator				= facade.retrieveMediator( NavMediator.NAME ) as NavMediator;
		
		// Tell the nav proxy that the load is complete
		navProxy.sectionLoadComplete	= true;
		var navItem:NavItem_VO			= navProxy.currentNavItem;
		// Make sure the nav is displaying the correct nav item in case the 
		// user has clicked another nav item since unloading began.
		navMediator.makeNavItemActive( navProxy.currentItemIndex );
		navProxy.changeUrlPath( navProxy.currentItemUrl, 0);
		
		switch( navItem.contentType )
		{
			case "portfolio":
				
				// Create the portfolio mediator
				var portfolioMediator:PortfolioMediator = new PortfolioMediator();
				facade.registerMediator( portfolioMediator );
				portfolioMediator.make();
				stageMediator.addNewSection( portfolioMediator );
				
				// Create the portfolio proxy
				var portfolioProxy:PortfolioProxy = PortfolioProxy.getInstance();
				facade.registerProxy( portfolioProxy );
				portfolioProxy.defaultProject = navProxy.defaultSectionContent;
				portfolioProxy.loadPortfolioXml( navItem.xmlPath );
			break;
			
			case "page":
			
				var temp:BaseSection = new BaseSection( "BASE" );
				facade.registerMediator( temp );
				temp.make();
				stageMediator.addNewSection( temp );
				
			break;
		}
		
		colorProxy.changeColorScheme( navItem.colorScheme );
	}
}
}