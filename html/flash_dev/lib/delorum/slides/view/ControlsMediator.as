package delorum.slides.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import delorum.slides.*;
import flash.display.Sprite;
import delorum.slides.view.components.*;
import flash.events.*;
import delorum.slides.view.components.events.ControlsEvent;

public class ControlsMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "controls_mediator";
	
	// Display
	private var _controls:Controls = new Controls();

	
	public function ControlsMediator( $holderMc:Sprite ):void
	{
		super( NAME );
		
		_controls.y = -20;
		_controls.addEventListener( ControlsEvent.ARROW_CLICK, _onArrowBtnClick, false,0,true );
		_controls.addEventListener( ControlsEvent.PLAY, _onPlay, false,0,true );
		_controls.addEventListener( ControlsEvent.SLIDE_BTN_CLICK, _onSlideBtnClick, false,0,true );
		_controls.addEventListener( ControlsEvent.PAUSE, _onPause, false,0,true );
		
		$holderMc.addChild( _controls );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	SlideShowFacade.INIT_SLIDES,
		    		SlideShowFacade.DISPLAY_NEW_SLIDE,
		 			SlideShowFacade.STOP_AUTOPLAY,
					SlideShowFacade.START_AUTOPLAY,
					SlideShowFacade.CHANGE_SLIDE_BY_INDEX ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SlideShowFacade.INIT_SLIDES:
				_controls.createControls( note.getBody() as Array );
			break;
			case SlideShowFacade.DISPLAY_NEW_SLIDE:
				var slideVo:Slide_VO = note.getBody() as Slide_VO;
				_controls.activateBtn( slideVo.index );
			break;
			case SlideShowFacade.START_AUTOPLAY:
				_controls.startAutoPlay();
			break;
			case SlideShowFacade.STOP_AUTOPLAY:
			case SlideShowFacade.CHANGE_SLIDE_BY_INDEX:
				_controls.stopAutoPlay()
			break
		}
	}
	
	// ______________________________________________________________ Make
	
	
	// ______________________________________________________________ Event Handlers

	
	private function _onSlideBtnClick ( e:ControlsEvent ):void{
		facade.sendNotification( SlideShowFacade.TRANSITION_SPEED_TO_CLICK );
		facade.sendNotification( SlideShowFacade.CHANGE_SLIDE_BY_INDEX, e.clickedSlideId );
	}
	
	private function _onPause ( e:ControlsEvent ):void{
		facade.sendNotification( SlideShowFacade.STOP_AUTOPLAY );
	}
	
	private function _onPlay ( e:ControlsEvent ):void{
		facade.sendNotification( SlideShowFacade.START_AUTOPLAY );
		facade.sendNotification( SlideShowFacade.TRANSITION_SPEED_TO_CLICK );
		facade.sendNotification( SlideShowFacade.NEXT_SLIDE, true );
	}
	

	private function _onArrowBtnClick ( e:ControlsEvent ):void{
		facade.sendNotification( SlideShowFacade.TRANSITION_SPEED_TO_CLICK );
		facade.sendNotification( SlideShowFacade.STOP_AUTOPLAY );
		
		if( e.arrowClickDirection == ControlsEvent.RIGHT )
			facade.sendNotification( SlideShowFacade.NEXT_SLIDE, true);
		else
			facade.sendNotification( SlideShowFacade.PREV_SLIDE, true);
			
	}
	
	
	
}
}