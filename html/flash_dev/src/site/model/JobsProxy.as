package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.*;
import site.SiteFacade;
import flash.events.*;
import delorum.loading.DataLoader;


public class JobsProxy extends Proxy implements IProxy
{
	public static const NAME:String = "jobs_proxy";

	public function JobsProxy( ):void
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
		var xml:XML = XML( e.target.data );
		var vo:Jobs_VO = new Jobs_VO();
		vo.css = String( xml.css.* );
		vo.openJobs = String( xml.openings.text.* );
		vo.generalBlurb = String( xml.blurb.text.* )
		sendNotification( SiteFacade.JOBS_XML_PARSED, vo )
	}
	
	//sendNotification( SiteFacade.NOTIFICATION, someParameter );
}
}