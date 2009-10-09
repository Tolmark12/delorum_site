package app
{

import app.control.*;
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;
import org.puremvc.as3.multicore.patterns.observer.Notification;

public class AppFacade extends Facade implements IFacade
{
	public static const STARTUP:String 							= "startup";
	
	// Data
	public static const CONFIG_DATA_LOADED_AND_PARSED			= "config_data_loaded_and_parsed";
	public static const CASESTUDIES_DATA_LOADED					= "casestudies_data_loaded";
	
	// State
	public static const CASESTUDIES_PARSED						= "quotes_parsed";
	public static const ACTIVATE_CASESTUDY						= "activate_quote";
	
	// User events
	public static const CASESTUDY_CLICKED						= "casestudy_clicked";
	public static const PREVIOUS								= "previous";
	public static const NEXT									= "next";
	
	
	public function AppFacade( key:String ):void
	{
		super(key);	
	}

	/** Singleton factory method */
	public static function getInstance( key:String ) : AppFacade 
    {
        if ( instanceMap[ key ] == null ) instanceMap[ key ] = new AppFacade( key );
        return instanceMap[ key ] as AppFacade;
    }
	
	public function startup($app:Object):void
	{
	 	sendNotification( STARTUP, $app ); 
	}

	/** Register Controller commands **/
	override protected function initializeController( ) : void 
	{
		super.initializeController();			
		
		// Init Command
		registerCommand( STARTUP, Startup );
		
		// Data Request Commands
		registerCommand( CONFIG_DATA_LOADED_AND_PARSED, DataRequests );
		registerCommand( CASESTUDIES_DATA_LOADED, DataRequests );
		
		// Click Commands
		registerCommand( CASESTUDY_CLICKED, Clicks );
		registerCommand( PREVIOUS, Clicks );
		registerCommand( NEXT, Clicks );
	}
}
}