package site.view.sections
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import delorum.loading.ImageLoader;
import site.SiteFacade;
import flash.events.*;
import flash.display.Sprite;
import site.view.StageMediator;

public class ImageSection extends BaseSection implements IMediator
{	
	public static const NAME:String = "image_section";
	private var _imagePath:String;
	private var _imageHolder:Sprite;
	
	public function ImageSection( $image:String ):void
	{
		super( NAME );
		_imagePath = $image;
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	 SiteFacade.BROWSER_RESIZE  ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case  SiteFacade.BROWSER_RESIZE:
				_centerImage();
				break;
		}
	}
	
	// ______________________________________________________________ Make
	
	override public function make ():void
	{
		super.make();
		_imageHolder = new Sprite();
		super._baseMc.addChild(_imageHolder);
		var ldr:ImageLoader = new ImageLoader( _imagePath, _imageHolder );
		ldr.onComplete	= _initImage;
		ldr.addItemToLoadQueue();
	}
	
	private function _initImage ( e:Event ):void
	{
		super.show();
		_centerImage();
	}
	
	private function _centerImage (  ):void
	{
		_imageHolder.x = StageMediator.stageCenter - _imageHolder.width / 2;
		_imageHolder.y = StageMediator.stageMiddle - _imageHolder.height/ 2;
	}
}
}