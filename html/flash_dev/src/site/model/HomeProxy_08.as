package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import site.model.vo.*;
import site.SiteFacade;
import flash.events.*;
import delorum.loading.DataLoader;
import site.model.vo.*;


public class HomeProxy_08 extends Proxy implements IProxy
{
	public static const NAME:String = "home_proxy_08";
	
	// Constructor
	public function HomeProxy_08( ):void { super( NAME ); };
	
	public function loadXml ( $xmlPath:String ):void
	{
		var ldr:DataLoader 	= new DataLoader( $xmlPath );
		ldr.onComplete		= _handleXmlLoaded;
		ldr.loadItem();
	}
	
	private function _handleXmlLoaded ( e:Event ):void
	{
		var ar:Array = new Array(); 
		var xml:XML  = XML( e.target.data );
		var vo:Home08_VO = new Home08_VO( xml );		
		sendNotification( SiteFacade.HOME_DATA_PARSED, vo );
	}
	
	
}
}