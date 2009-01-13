package {

import delorum.echo.EchoMachine;
import flash.events.*;
import flash.display.*;
import site.SiteFacade;

/**
* 	Delorlum Corporate site
* 	
* 	@language ActionScript 3, Flash 9.0.0
* 	@author   Mark Parson. 2008-06-30
* 	@rights	  Copyright (c) Delorum 2008. All rights reserved	
*/


public class DelorumSite extends Sprite 
{
	public function DelorumSite():void 
	{
		// For printing any errors / message
		//EchoMachine.setEchoModeAutomatically( this.stage );
		//EchoMachine.initForExternalJavascript();
		
		EchoMachine.echoMode = EchoMachine.AIR;
		EchoMachine.startLogging(this);
		
		// Initialze the site facade and begin
		var siteFacade:SiteFacade = SiteFacade.getInstance( 'site_facade' );
		siteFacade.begin( this );
	}
	
	// ______________________________________________________________ Color constants
	
	public static const WHITE:Number 		= 0xFFFFFF;
	public static const TAN:Number 			= 0xD4B17D;
	public static const TAN_LIGHT:Number 	= 0xF2CA8F;
	public static const GRAY_LIGHT:Number 	= 0xCCCCCC;
	public static const GRAY_MED:Number 	= 0x404040;
	public static const GRAY_DARK:Number 	= 0x1B1D1F;
	public static const GRAY_STUB:Number 	= 0x767676;	// used for the border of the stubs
	
	// ______________________________________________________________ Font Size constants
	
	public static const PROJECT_TITLE_FONT_SIZE:uint 	= 18;
	public static const H1_FONT_SIZE:uint 				= 14;
	public static const BODY_FONT_SIZE:uint 			= 6;
}
}
/*

site
section_modulds
	- common
		• Receive close command
	- portfolio
	- page

*/