package site
{
import flash.display.Sprite;
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.control.*;


public class SiteFacade extends Facade implements IFacade
{
	// Initializing the site
	public static const STARTUP:String 					= "startup";   				// Starts the application
	public static const BUILD_NAV:String 				= "build_nav";				// Build the Navigation
	                                                                            	
	// Javascript browser scrolling                                             	
	public static const FLASH_HEIGHT_CHANGED:String 	= "content_change";   		// Called when the height of the content area changes
	public static const BROWSER_RESIZE:String 			= "browser_resize";			// Called when the browser is resized
	public static const BROWSER_SCROLL:String 			= "browser_scroll";			// Called when the browser scrolls
    public static const MOVE_BROWSER_SCROLL:String 		= "move_browser_scroll";	// Move the browser's scroll bar

	// SWFAddress TODO: rename these events to avoid confusion
	public static const FLASH_URL_CHANGED:String 		= "url_changed";			// Called when the flash content has changed
	public static const BROWSER_URL_CHANGED:String 		= "browser_url_changed";	// Called when the browser url has changed
                                        	
	// Navigation                                                               	
	public static const NAV_BTN_CLICK:String 			= "nav_btn_click";			// Passes the index of the btn clicked
	public static const CUR_BTN_CLICKED_AGAIN:String 	= "cur_btn_clicked_again";	// Passes the index of the btn clicked (when button is alread active and clicked)
	public static const HOME_BTN_CLICK:String 			= "home_btn_click";			// Called when logo is clicked 
	
	// Changing the color Scheme
	public static const CHANGE_COLOR_SCHEME:String 		= "change_color_scheme";	// Called when colors should change
	                                                                	
	// Content                                                                  	
	public static const UNLOAD_CURRENT_SECTION:String 	= "unload_cur_sect";		// Called when unloading of current content begins
	public static const UNLOAD_COMPLETE:String 			= "unload_complete";		// Called when unload of current section finished
	public static const LOAD_NEW_SECTION:String 		= "load_new_sect";			// Called to begin loading new section
	                                                                            	
	// Portfolio                                                                	
	public static const INIT_PORTFOLIO:String 			= "init_portfolio";			// Called to initialize the portfolio
	public static const PROJECT_STUB_CLICK:String 		= "project_stub_click";		// Called when a project stub is clicked
	public static const DEACTIVATE_STUB_CLICK:String 	= "deactivate_stub_click";
	public static const SHOW_STUB_OVERVIEW:String 		= "show_stub_overview";		// Brings stub to semi-active state
	public static const SHOW_STUB_DETAILS:String 		= "show_stub_details";		// Shows full project details
	public static const SCROLL_PORTFOLIO:String 		= "scroll_portfolio";		// Scroll the portfolio a certain percentage (0-1)
	public static const LOAD_PROJECT_XML:String 		= "LOAD_PROJECT_XML";		// Request the xml for the current active project
	public static const PROJECT_XML_LOADING:String 		= "project_xml_loading";	// XML loading started
	public static const PROJECT_XML_LOADED:String 		= "project_xml_loaded";		// XML loading complete
	public static const DEACTIVATE_PROJECT:String 		= "deactivate_project";
	public static const HIDE_CASE_STUDY_CLICK:String 	= "hide_case_study";		// Hide the current project's case study
	public static const HIDE_CASE_STUDY:String 			= "hide_case_study";		// Hide the current project's case study
	public static const CASE_STUDY_HIDDEN:String 		= "case_study_hidden";		// Case study is hidden
	
	public function SiteFacade( key:String ):void
	{
		super(key);	
	}

	/** Singleton factory method */
	public static function getInstance( key:String ) : SiteFacade 
    {
        if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new SiteFacade( key );
        return instanceMap[ key ] as SiteFacade;
    }
	
	/**	Start the ball rolling */
	public function begin( $rootSprite:Sprite ):void
	{
	 	sendNotification( STARTUP, $rootSprite ); 
	}

	/** Register Controller commands */
	override protected function initializeController( ) : void 
	{
		super.initializeController();
		registerCommand( STARTUP, Startup 								);
		registerCommand( BUILD_NAV, BuildNav							);
		registerCommand( NAV_BTN_CLICK, NavBtnClick 					);
		registerCommand( UNLOAD_CURRENT_SECTION, UnloadCurrentSection 	);
		registerCommand( LOAD_NEW_SECTION, LoadNewSection 				);
		registerCommand( PROJECT_STUB_CLICK, ProjectStubClick 			);
		registerCommand( LOAD_PROJECT_XML, LoadProjectXml	 			);
		registerCommand( BROWSER_URL_CHANGED, BrowserUrlChanged	 		);
		registerCommand( DEACTIVATE_STUB_CLICK, DeactivateStubClick	 	);
		registerCommand( HIDE_CASE_STUDY_CLICK, HideCaseStudyClick	 	);
		
	}

}
}