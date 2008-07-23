package delorum.loading
{

import flash.events.*;
import delorum.loading.progress.BaseProgressDisplay;

public class BaseLoader extends EventDispatcher
{
	// 
	private static var _currentlyLoading:Boolean;
	private static var _loadQueue:Array 		= new Array();
	
	// 
	private static var _snapShotIncrament:uint  = 0;	
	private static var _loadQueueSnapShot:Array	= new Array();
	
	private var _onErrorFunction:Function;
	
	public function BaseLoader():void
	{}
	
	protected function get _eventListener (  ):EventDispatcher
	{
		trace( "The '_eventListner' getter function should be overridden in the sub class!!");
		return null;
	}
	
	// ______________________________________________________________ Loading Handles
	/** Adds an item to the end of the load queue. */
	public function addItemToLoadQueue (  ):void
	{
		_loadQueue.push( this );
		loadNextItem();
	}
	
	/** Loads item immediately */
	public function loadItem (  ):void
	{
        trace( "The 'loadItem' function should be overridden in the sub class!!");
	}
	
	protected function isStillActive (  ):Boolean
	{
		trace( "The 'isStillActive' function should be overridden in the sub class!!");
		return true;
	}
	
	
	// ______________________________________________________________ Static functions, the meat of the loading done here. 
	
	/** 
	* 	@private Moving through the load queue
 	*/
	private function loadNextItem ():void
	{
		if( !_currentlyLoading && _loadQueue.length != 0 )
		{
			var nextLoad:BaseLoader = _loadQueue.shift();
			
			// Double check that holder mc hasn't been removed or deleted
			if( isStillActive() )
			{
				_currentlyLoading = true;
				nextLoad.loadItem();
				nextLoad.onComplete = loadComplete;
				nextLoad.onError	= loadComplete;
			}else{
				loadNextItem();
			}
		}
	}
	
	private function loadComplete ( e:Event ):void
	{
		_currentlyLoading = false;
		loadNextItem();
	}
	
	// ______________________________________________________________ Associate with a progress indicator
	
	public function connectToProgressDisplay ( $progressDisplay:BaseProgressDisplay ):void
	{
		_eventListener.addEventListener( ProgressEvent.PROGRESS, $progressDisplay.updateHandler );
		_eventListener.addEventListener( Event.INIT, $progressDisplay.completeHandler );
	}
	
	// ______________________________________________________________ Set Event Handlers
	/** Set callback function to be triggered on Load Complete */
	public function set onComplete	($f:Function):void { _eventListener.addEventListener( Event.COMPLETE, $f); };
	
	/** Set callback function to be triggered on Load Error */
	public function set onError		($f:Function):void { _eventListener.addEventListener( IOErrorEvent.IO_ERROR, _errorHandler); _onErrorFunction = $f };
	
	/** Set callback function to be triggered on Load Progress */
	public function set onProgress	($f:Function):void { _eventListener.addEventListener( ProgressEvent.PROGRESS, $f); };
	
	/** Set callback function to be triggered on Load initialization */
	public function set onInit		($f:Function):void { _eventListener.addEventListener( Event.INIT, $f); };

	private function _errorHandler ( e:Event ):void
	{
		trace( e );
		_onErrorFunction()
	}
}

}