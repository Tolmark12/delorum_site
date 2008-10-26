package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.*;
import site.SiteFacade;
import delorum.loading.DataLoader;
import flash.events.*;

public class HomeProxy extends Proxy implements IProxy
{
	public static const NAME:String = "home_proxy";

	public function HomeProxy( ):void
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
		var xml:XML  = XML( e.target.data );
		for each( var teaser:XML in xml.teasers.teaser )
		{
			var vo:HomeTeaser_VO = new HomeTeaser_VO();
			vo.imageRightPath	= teaser.imgR.@src;
			vo.imageLeftPath	= teaser.imgL.@src;
			vo.headLine			= teaser.h1;
			vo.body				= teaser.p;
			vo.href				= teaser.a.@href;
			vo.link				= teaser.a;
			ar.push(vo);
		}
		
		sendNotification( SiteFacade.HOME_TEASER_XML_PARSED, ar )
	}
	
}
}