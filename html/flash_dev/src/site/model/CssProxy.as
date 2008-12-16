package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.*;
import site.SiteFacade;
import flash.events.*;
import delorum.loading.DataLoader;


public class CssProxy extends Proxy implements IProxy
{
	public static const NAME:String = "css_proxy";
	
	private static var _cssObj:Object = new Object();;
	
	public function CssProxy( ):void
	{
		super( NAME );
	}
	
	public function loadCss ( $cssFile:String ):void
	{
		var ldr:DataLoader 			= new DataLoader( $cssFile );
		ldr.addEventListener( Event.COMPLETE, _handleCssLoadComplete);
		ldr.loadItem();
	}
	
	private function _handleCssLoadComplete ( e:Event ):void
	{
		_parseCss( XML( e.target.data ) );
		sendNotification( SiteFacade.CSS_LOADED );
	}
	
	private function _parseCss ( $xml:XML ):void
	{
		for each( var node:XML in $xml.styles.style )
		{
			var vo:Css_VO = new Css_VO();
			vo.css = String( node );
			_cssObj[ node.@id ] = vo;
		}
		
		Css_VO.defaultCss = _cssObj["default"];
	}
	
	public static function getCss ( $id ):Css_VO
	{
		return _cssObj[$id] as Css_VO;
	}

	//sendNotification( SiteFacade.NOTIFICATION, someParameter );
}
}