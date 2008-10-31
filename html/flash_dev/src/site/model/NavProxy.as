package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;

import flash.display.Sprite;
import delorum.loading.DataLoader;
import flash.events.*;
import site.SiteFacade;
import site.model.vo.*;

import delorum.echo.EchoMachine;

public class NavProxy extends Proxy implements IProxy
{
	public static const NAME:String = "nav_proxy";
	public var  sectionLoadComplete:Boolean = true; 		// Set to false when a new section is loading
	
	private var _navArray:Array;							// Holds a list of the navigation item value objects
	private var _defaultBgColor:uint;
	private var _currentNavItemIndex:int 	= -1;			// Current Nav item
	private var _pathArray:Array	 		= new Array();
	private var _newSectionDefaultContent:String;
	private var _defaultIndex:uint;
	
	public function NavProxy( ):void
	{
		super( NAME );
	}
	
	
	// ______________________________________________________________ Loading XML
	
	public function loadXml ( $stage:Sprite ):void
	{
		// If this is on the web, and the param xmlPath is defined, use that instead of this test string to load the xml
		var xmlPath:String	= ( $stage.loaderInfo.parameters.xmlPath   != null )? $stage.loaderInfo.parameters.xmlPath   : 'content/xml/site.xml' ;
		_defaultBgColor		= ( $stage.loaderInfo.parameters.defaultBg != null )? uint($stage.loaderInfo.parameters.defaultBg) :0x978061 ;
		var ldr:DataLoader 	= new DataLoader( xmlPath );
		ldr.onComplete		= _handleXmlLoaded;
		ldr.addItemToLoadQueue();
	}
	
	private function _handleXmlLoaded ( e:Event ):void
	{
		var xml:XML = XML(e.target.data);
		_createNav( xml.nav );
		sendNotification( SiteFacade.BUILD_NAV, _navArray );
	}
	
	// ______________________________________________________________ Create Nav Value Objects
	
	private function _createNav ( $navNode:XMLList ):void
	{
		_navArray = new Array();
		for each( var node:XML in $navNode.nav_item )
		{
			var vo:NavItem_VO = new NavItem_VO();
			vo.bgColor				= (String(node.@bg).length == 0)? null : uint( "0x" + node.@bg ); 
			vo.title 				= String( node.title);
			vo.contentType			= node.@contentType;
			vo.section				= node.@section;
			vo.arrayIndex			= _navArray.length;
			vo.xmlPath				= $navNode.@xmlDir + node.@xml;
			vo.colorScheme			= node.@colorScheme;
			vo.buttonType			= node.@buttonType;
			vo.extraData			= ( node.extraData.toXMLString().length != 0 )? XML( node.extraData[0].toXMLString() ) : null ;
			vo.clickAction			= node.@clickAction;
			vo.clickActionParam		= node.@clickActionParam;
			
			// default section
			if( vo.section == $navNode.@defaultSection ) 
				_defaultIndex = vo.arrayIndex;
			
			_navArray.push( vo );
		}
	}
	
	// ______________________________________________________________ Change active nav item
	
	public function changeSection ( $index:uint, $defaultContent:String = null ):void
	{
		var vo:NavItem_VO = _navArray[ $index ];
		
		switch (vo.clickAction)
		{
			case "newSection" :
				// if this section is not already active...
				if( _currentNavItemIndex != $index ){
					// ...load new section
					var isFirstSectiontoLoad:Boolean = _currentNavItemIndex == -1;
					_currentNavItemIndex = $index;
					
					// If the new section has some sort of default content to display...
					if( $defaultContent != null ) 
						_newSectionDefaultContent = $defaultContent; 
					else
						_newSectionDefaultContent = "";
					
					if( sectionLoadComplete ) {
						sectionLoadComplete = false;
						if( isFirstSectiontoLoad )
							sendNotification( SiteFacade.LOAD_NEW_SECTION );
						else
							sendNotification( SiteFacade.UNLOAD_CURRENT_SECTION, _currentNavItemIndex );
					}		
				}
				// fire notification that current section's btn was clicked
				else{
					sendNotification( SiteFacade.CUR_BTN_CLICKED_AGAIN );
				}
			break;
			case "sendNotification" :
				sendNotification( SiteFacade[ vo.clickActionParam ] )
			break;
		}	
	}
	
	public function changeSectionBySectionName ( $section:String, $defaultContent:String = null ):void
	{
		var newContentIndex:uint;
		
		// If no section is specified... 
		if( $section == "" )
		{
			//...load the default content. 
			// This is likely to happen when the visitor comes
			// to the default page (www.delorum.com/)
			newContentIndex = _defaultIndex;
		}
		else
		{	
			// loop through nav items to find matching section name
			var len:uint = _navArray.length;
			for ( var i:uint=0; i<len; i++ ) 
			{
				var vo:NavItem_VO = _navArray[i] as NavItem_VO;
				if( vo.section == $section )
					newContentIndex = vo.arrayIndex
			}
		}
		
		changeSection( newContentIndex, $defaultContent );
	}
	
	public function changeSectionWithSlashedName ( $slashedName:String ):void
	{
		var ar = $slashedName.split("/");
		changeUrlPath($slashedName);
		changeSectionBySectionName(ar[0], ar[1]);
	}
	
	public function changeUrlPath ( $path:String, $level:uint = 0 ):void
	{
		// If new path is different than old...
		if( _pathArray[$level] != $path ) 
		{
			// reset all trailing slashes ie:
			// trace( pathArray ); // [ "portfolio", "web", "Playmill" ];
			// changeUrlPath("home", 0)'
			// trace( portfolio ); // [ "home" ]; (web and Playmill were "popped" off)

			var len:uint = _pathArray.length;
			for ( var i:uint=$level; i<len; i++ ) 
			{
				_pathArray.pop();
			}
			_pathArray[$level] = $path;
			sendNotification( SiteFacade.FLASH_URL_CHANGED, urlPath );
		}
	}
	
	// ______________________________________________________________ Getters / Setters
	
	public function get currentNavItem   	(  ):NavItem_VO{ return _navArray[ _currentNavItemIndex ]; };
	public function get currentItemIndex 	(  ):uint		{ return currentNavItem.arrayIndex; };
	public function get currentItemUrl   	(  ):String	{ return (currentNavItem == null)? null : currentNavItem.section;    };
	public function get defaultSectionContent (  ):String{ return _newSectionDefaultContent; };
	
	public function get defaultBgColor   (  ):uint      { return _defaultBgColor; };1
	
	// Get / Set the URL
	public function get urlPath ():String  {
		var str:String = ""; 
		var len:uint = _pathArray.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			str += _pathArray[i];
			str += ( i == len -1 )? "" : "/" ;
		}
		return str;
	};
}
}