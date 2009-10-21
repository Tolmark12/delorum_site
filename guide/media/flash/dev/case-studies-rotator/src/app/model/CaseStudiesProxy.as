package app.model
{

import app.model.vo.*;
import app.AppFacade;
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import delorum.utils.Sequence;

public class CaseStudiesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "casestudies_proxy";
	
	private var _sequence:Sequence;
	
	// Constructor
	public function CaseStudiesProxy( ):void
	{ 
		super( NAME );
	}
	
	// _____________________________ API
	
	public function init ( $json:Object ):void
	{
		var caseStudies:Array = new Array();
		
		var len:uint = $json.caseStudies.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var caseStudyVo:CaseStudyVo		= new CaseStudyVo( $json.caseStudies[i] );
			caseStudyVo.index				= i;
			
			caseStudies.push( caseStudyVo );
		}

		_sequence = new Sequence( caseStudies );
		
		sendNotification( AppFacade.CASESTUDIES_PARSED, caseStudies );
		sendNotification( AppFacade.ACTIVATE_CASESTUDY, _sequence.currentItem );
	}
	
	public function activateCaseStudyByIndex ( $index:Number ):void
	{
		if( _sequence.changeItemByIndex( $index ) )
			sendNotification( AppFacade.ACTIVATE_CASESTUDY, _sequence.currentItem );
	}
	
	public function previous ( ):void
	{
		if( _sequence.prev(true) )
			sendNotification( AppFacade.ACTIVATE_CASESTUDY, _sequence.currentItem );
	}
	
	public function next ( ):void
	{
		if( _sequence.next(true) )
			sendNotification( AppFacade.ACTIVATE_CASESTUDY, _sequence.currentItem );
	}
	
}
}