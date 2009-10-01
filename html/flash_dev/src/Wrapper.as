package 
{

import flash.display.Sprite;
import flash.net.URLRequest;
import flash.display.Loader;
import flash.events.Event;
import flash.events.ProgressEvent;

public class Wrapper extends Sprite
{
	public function Wrapper():void
	{
		startLoad();
	}

	function startLoad () {
		var mLoader:Loader = new Loader();
		var mRequest:URLRequest = new URLRequest("DelorumSite.swf");
		mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
		mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
		mLoader.load(mRequest);
	}

	function onCompleteHandler ( loadEvent:Event ){
		this.stage.addChild(loadEvent.currentTarget.content);
	}
	function onProgressHandler(mProgress:ProgressEvent)
	{
		var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
		trace(percent);
	}
}

}