package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import flash.display.Sprite;
import flash.events.*;
import delorum.loading.*;
import site.model.vo.*;
import site.SiteFacade;

public class ColorSchemeProxy extends Proxy implements IProxy
{
	public static const NAME:String = "color_scheme_proxy";
	public static var defaultColorScheme:ColorScheme_VO;
	private static var _colorSchemes:Object;
	private static var _currentScemeId:String;

	public function ColorSchemeProxy( ):void
	{
		super( NAME );
	}
	
	// ______________________________________________________________ Loading XML
	
	public function loadXml ( $stage:Sprite ):void
	{
		// If this is on the web, and the param xmlPath is defined, use that instead of this test string to load the xml
		var colorPath:String	= ( $stage.loaderInfo.parameters.colorXmlPath   != null )? $stage.loaderInfo.parameters.colorXmlPath   : 'content/xml/color_schemes.xml' ;
		var ldr:XmlLoader 		= new XmlLoader( colorPath );
		ldr.onComplete			= _handleXmlLoaded;
		ldr.addItemToLoadQueue();
	}
	
	private function _handleXmlLoaded ( e:Event ):void
	{
		var xml:XML = XML(e.target.data);
		_createColorSchemes( xml );
	}
	
	private function _createColorSchemes ( $xml:XML):void
	{
		_colorSchemes = new Object();
		for each( var node:XML in $xml.colorScheme )
		{
			var vo:ColorScheme_VO     = new ColorScheme_VO();
			
			// set params
			_setVoParam( vo, node, "nav_up" 	);
			_setVoParam( vo, node, "nav_hover" 	);
			_setVoParam( vo, node, "nav_active" 	);
			_setVoParam( vo, node, "bg" 		);
			_setVoParam( vo, node, "scrollbar_track"		);
			_setVoParam( vo, node, "scrollbar_track_border"	);
			_setVoParam( vo, node, "scrollbar_bar" 			);
			_setVoParam( vo, node, "logo"					);
			_setVoParam( vo, node, "work_h1"					);
			_setVoParam( vo, node, "work_h2"					);
			_setVoParam( vo, node, "work_body"					);
			
			
			// Save vo
			_colorSchemes[ node.@id ] = vo;
			
			// If default, set default vo
			if( node.@id == "default" ) 
				defaultColorScheme = vo;
		}
		
		changeColorScheme( $xml.firstScheme );
	}
	
	public function changeColorScheme ( $id:String ):void
	{
		if( _currentScemeId != $id ){ 
			_currentScemeId = $id;
			sendNotification( SiteFacade.CHANGE_COLOR_SCHEME, _colorSchemes[$id]);
		}
	}
	
	private function _setVoParam ( $vo:ColorScheme_VO, $node:XML, $param:String ):void
	{
		$vo[$param] = ( String( $node.colors.@[$param]).length > 0 )? uint("0x" + $node.colors.@[$param]) : defaultColorScheme[$param] as uint ;
	}
	
	public static function get currentColorScheme (  ):ColorScheme_VO{ return _colorSchemes[_currentScemeId]; };
}
}

/*

	public var nav_up:uint;
	public var nav_hover:uint;
	public var bg:uint;
	public var scrollbar_track:uint;
	public var scrollbar_track_border:uint;
	public var scrollbar_bar:uint;
	
*/