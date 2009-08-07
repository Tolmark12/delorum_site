package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import flash.display.*;
import site.SiteFacade;
import caurina.transitions.Tweener;

public class BaseSection extends Mediator implements IMediator
{	
	protected var _baseMc:Sprite;
	
	public function BaseSection( $name:String ):void
	{
		super( $name );
   	}
	
	// ______________________________________________________________ Show and Hide
	
	public function show (  ):void
	{
//		trace( ":: Showing ::" );
		// Default showing behavior
		Tweener.addTween( _baseMc, { alpha:1, time:.6 } );
		_updateHeight();
	}
	
	public function hide (  ):void
	{
//		trace( ":: Hiding ::" );
		Tweener.addTween( _baseMc, { alpha:0, time:0.1, onComplete:_unloadComplete } );
	}
	
	// ______________________________________________________________ Make and unmake
	
	public function make ( ):void
	{
//		trace( "==== Adding New Component ====" );
//		trace( ":: Making " + this.getMediatorName() + " Component ::" );
		_baseMc = new MovieClip();
		_baseMc.alpha = 0;
	}
	
	public function unload (  ):void
	{
//		trace( ":: Preparing to unload " + this.getMediatorName() + " Component  ::" );
		hide();
	}
	
	protected function _unloadComplete (  ):void
	{
//		trace( ":: Unload Complete ::" );
		setViewComponent( null );
		_baseMc.parent.removeChild( _baseMc );
		sendNotification( SiteFacade.LOAD_NEW_SECTION );
		facade.removeMediator(this.getMediatorName());
	}
	
	
	// ______________________________________________________________ Getters / Setters
	
	public function get baseMc (  ):Sprite{ return _baseMc; };
	
	// ______________________________________________________________ Helpers
	
	protected function _updateHeight (  ):void
	{
		sendNotification( SiteFacade.FLASH_HEIGHT_CHANGED );
	}
}
}