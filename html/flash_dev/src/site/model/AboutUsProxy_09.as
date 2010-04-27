package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.*;
import site.SiteFacade;
import flash.events.*;
import delorum.loading.DataLoader;


public class AboutUsProxy_09 extends Proxy implements IProxy
{
	public static const NAME:String = "about_us_proxy_09";

	public function AboutUsProxy_09( ):void
	{
		super( NAME );
	}
	
	public function loadXml ( $xmlPath:String ):void
	{
		var ldr:DataLoader 	= new DataLoader( $xmlPath );
		ldr.onComplete		= _handleXmlLoaded;
		ldr.loadItem();
	}
	
	private function _handleXmlLoaded ( e:Event ):void
	{
		var ar:Array = new Array(); 
		trace(  e.target.data  );
		//var xml:XML  = XML( e.target.data );
		//for each( var blurb:XML in xml.tags.tag )
		//{
		//	var vo:AboutUsBlurb_VO = new AboutUsBlurb_VO();
		//	vo.title = blurb.title;
		//	vo.number = blurb.number;
		//	vo.htmlText = String( blurb.text.* );		
		//	ar.push(vo);
		//}
		//
		//AboutUsBlurb_VO.css = String( xml.css.* );
		sendNotification( SiteFacade.ABOUT_US_09_XML_PARSED, ar )
	}
	
	//sendNotification( SiteFacade.NOTIFICATION, someParameter );
}
}