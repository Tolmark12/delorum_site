package app.model
{

import app.model.vo.*;
import app.AppFacade;
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import flash.display.Stage;
import flash.events.*;
import delorum.loading.DataLoader;
import com.adobe.serialization.json.JSON;

public class ExternalDataProxy extends Proxy implements IProxy
{
	public static const NAME:String = "external_data_proxy";
	
	private var _configVo:ConfigVo;
	
	// Constructor
	public function ExternalDataProxy( ):void
	{ 
		super( NAME );
	};
	
	// _____________________________ API
	
	public function getConfigData ( $stage:Stage ):void
	{
		var configData:String = ( $stage.loaderInfo.parameters.configData != null )? $stage.loaderInfo.parameters.configData : 'content/json/Config.json' ;
		var dataLoader:DataLoader = new DataLoader( configData );
		dataLoader.addEventListener( Event.COMPLETE, _onConfigLoaded, false, 0, true );
		dataLoader.loadItem();
	}
	
	public function loadCaseStudiesData (  ):void
	{   
		var dataLoader:DataLoader = new DataLoader( _configVo.services.getCaseStudiesData );
		dataLoader.addEventListener( Event.COMPLETE, _onCaseStudiesDataLoaded, false, 0, true );
		dataLoader.loadItem();
	}
	
	// _____________________________ Event Handlers
	
	private function _onConfigLoaded ( e:Event ):void {
		_configVo = new ConfigVo( JSON.decode( e.target.data ) );
		sendNotification( AppFacade.CONFIG_DATA_LOADED_AND_PARSED, _configVo );
	}
	
	private function _onCaseStudiesDataLoaded ( e:Event ):void{
		sendNotification( AppFacade.CASESTUDIES_DATA_LOADED, JSON.decode(e.target.data) );
	}
}
}