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
		var navProxy:NavProxy 						= facade.retrieveProxy( NavProxy.NAME ) as NavProxy;
		var colorProxy:ColorSchemeProxy 			= facade.retrieveProxy( ColorSchemeProxy.NAME ) as ColorSchemeProxy;
		var stageMediator:StageMediator				= facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
		var navMediator:NavMediator					= facade.retrieveMediator( NavMediator.NAME ) as NavMediator;
		var browserUrlMediator:BrowserUrlMediator	= facade.retrieveMediator(BrowserUrlMediator.NAME ) as BrowserUrlMediator;
		
		
		// Tell the nav proxy that the load is complete
		navProxy.sectionLoadComplete	= true;
		var navItem:NavItem_VO			= navProxy.currentNavItem;
		
		// Make sure the nav is displaying the correct nav item in case the 
		// user has clicked another nav item since unloading began.
		navMediator.makeNavItemActive( navProxy.currentItemIndex );
		navProxy.changeUrlPath( navProxy.currentItemUrl, 0);
		
		// This is for google analytics, so when a link is clicked, we know which page was active for the click.
		browserUrlMediator.activePage = navItem.contentType;
		
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
			
			case "home" :
				var homeMediator:HomeMediator = new HomeMediator();
				facade.registerMediator( homeMediator );
				homeMediator.make();
				stageMediator.addNewSection( homeMediator );
				
				var homeProxy:HomeProxy = new HomeProxy();
				facade.registerProxy( homeProxy );
				homeProxy.loadXml( navItem.xmlPath );				
			break;
			
			case "home_08" :
				var homeMediator08:HomeMediator_08 = new HomeMediator_08();
				facade.registerMediator( homeMediator08 );
				homeMediator08.make();
				stageMediator.addNewSection( homeMediator08 );
				
				var homeProxy08:HomeProxy_08 = new HomeProxy_08();
				facade.registerProxy( homeProxy08 );
				homeProxy08.loadXml( navItem.xmlPath );
			break;
			
			case "about_us" :
				var aboutMediator:AboutUsMediator = new AboutUsMediator();
				facade.registerMediator( aboutMediator );
				aboutMediator.make();
				stageMediator.addNewSection( aboutMediator );
				
				var aboutProxy:AboutUsProxy = new AboutUsProxy();
				facade.registerProxy( aboutProxy );
				aboutProxy.loadXml( navItem.xmlPath );
			break;
			
			case "about_us_09" :
				var aboutMediator09:AboutUsMediator_09 = new AboutUsMediator_09();
				facade.registerMediator( aboutMediator09 );
				aboutMediator09.make();
				stageMediator.addNewSection( aboutMediator09 );
				
				var aboutProxy09:AboutUsProxy_09 = new AboutUsProxy_09();
				facade.registerProxy( aboutProxy09 );
				aboutProxy09.loadXml( navItem.xmlPath );
			break;
			
			case "jobs" :
				var jobsMediator:JobsMediator = new JobsMediator();
				facade.registerMediator( jobsMediator );
				jobsMediator.make();
				stageMediator.addNewSection( jobsMediator );
				
				var jobsProxy:JobsProxy = new JobsProxy();
				facade.registerProxy( jobsProxy );
				jobsProxy.loadXml( navItem.xmlPath );
			break;
			
			case "page":
			
				var temp:BaseSection = new BaseSection( "BASE" );
				facade.registerMediator( temp );
				temp.make();
				stageMediator.addNewSection( temp );
				
			break;
			
			case "image":
				
				/*trace( navItem.extraData.@image  + '  :  ' + '!' );*/
				var image:ImageSection = new ImageSection( navItem.extraData.@image );
				facade.registerMediator( image );
				image.make(   );
				stageMediator.addNewSection( image );
				
			break
		}
		
		colorProxy.changeColorScheme( navItem.colorScheme );
	}
}
}