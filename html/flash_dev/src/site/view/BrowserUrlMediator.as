package site.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import SWFAddress;
import SWFAddressEvent;
import delorum.utils.echo;
import flash.external.ExternalInterface;
import flash.net.navigateToURL;
import site.SiteFacade;

public class BrowserUrlMediator extends Mediator implements IMediator
{	
	public static const BROWSER_TITLE_PREFACE:String = "Delorum Design | ";
	public static const NAME:String = "browser_url_mediator";
	
	private var _sendTime:Date;
	public var activePage:String = "++++++";
	
	public function BrowserUrlMediator( ):void
	{
		super( NAME, viewComponent );
		
		SWFAddress.addEventListener(SWFAddressEvent.CHANGE, _handleSwfAddressChange );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ SiteFacade.FLASH_URL_CHANGED ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SiteFacade.FLASH_URL_CHANGED:
				_setNewUrl( note.getBody() as String );
				break;
		}
	}
	
	private function _handleSwfAddressChange ( e:SWFAddressEvent ):void
	{
		if( _sendTime != null )
		{ 
			var receiveTime = new Date();
			if( receiveTime.time - _sendTime.time < 10 )
			{
				_sendTime = null;
				return void;
			}
			_sendTime = null;
		}
		
		//SWFAddress.setTitle(formatTitle(e.value));
		//SWFAddress.setValue(e.target.deepLink);
		//SWFAddress.setStatus(e.target.deepLink);
		//SWFAddress.resetStatus();
		//echo(e.value);
		sendNotification( SiteFacade.BROWSER_URL_CHANGED,  /*"/portfolio/Playmill_Theatre/"*/  e.value );
	}
	
	public function _setNewUrl ( $url:String = ""):void
	{
		_sendTime = new Date();
		//trace( activePage + "->" + $url );
		ExternalInterface.call( "pageTracker._trackPageview", activePage + "->" + $url );
		SWFAddress.setValue( $url );
		
		var look:RegExp		 = /_/;
		var pageTitle:String = $url.replace( look, " ");
		SWFAddress.setTitle( BROWSER_TITLE_PREFACE + pageTitle);
	}
	

	
}
}