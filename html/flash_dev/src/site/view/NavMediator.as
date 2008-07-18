package site.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.SiteFacade;
import flash.display.Sprite;
import site.model.vo.*;
import flash.events.*;
import swc_components.NavButtonMain;

public class NavMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "navigation_mediator";

	private var _navSprite:Sprite;					// Main Holder Sprite
	private var _navAr:Array;						// List of the nav buttons
	private var _currentBtn:NavButtonMain_swc;		// Store reference to the current nav button
	
	public function NavMediator():void
	{
		super( NAME );
   	}

	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ SiteFacade.BUILD_NAV, 
		 		 SiteFacade.UNLOAD_CURRENT_SECTION,
		 		 SiteFacade.LOAD_NEW_SECTION,
		 		 SiteFacade.CHANGE_COLOR_SCHEME,  ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case SiteFacade.BUILD_NAV:
				_buildNav( note.getBody() as Array );
				break;
			case SiteFacade.UNLOAD_CURRENT_SECTION:
				makeNavItemActive( note.getBody() as uint );
				break;
			case SiteFacade.CHANGE_COLOR_SCHEME:
				_changeBtnColors( note.getBody() as ColorScheme_VO );
				break;
		}
	}
	
	// ______________________________________________________________ Building Nav	
	private function _buildNav ( $navItems:Array ):void
	{
		var xPos:uint = 0;
		var padding:uint = 30;
		_navAr = new Array();
		var navHolder:Sprite = new Sprite();
		_navSprite.addChild(navHolder);
		
		var len:uint = $navItems.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var navItem:NavItem_VO 			= $navItems[i];
			var navBtn:NavButtonMain_swc 	= new NavButtonMain_swc();
			navBtn.title = navItem.title;
			navBtn.drawHitArea();
			navBtn.index = i;
			_navAr[navItem.arrayIndex] = navBtn;
			
			navBtn.addEventListener( MouseEvent.CLICK, _handleNavBtnClick );
			navBtn.x = xPos;
			navHolder.addChild(navBtn);
			xPos += navBtn.textWidth + padding;
			
			if( i < len - 1 ) {
				var divider:NavDivider_swc = new NavDivider_swc();
				divider.x = xPos - padding / 2.3;
				navHolder.addChild( divider );
			}
		}
		
		// right align the buttons on the 0 pos
		navHolder.x = -xPos;
	}
	
	// ______________________________________________________________ Color Scheme change
	
	private function _changeBtnColors ( $colorScheme:ColorScheme_VO ):void
	{
		NavButtonMain.COLOR_UP		= $colorScheme.nav_up;
		NavButtonMain.COLOR_HOVER	= $colorScheme.nav_hover;
		NavButtonMain.COLOR_ACTIVE 	= $colorScheme.nav_active;
		
		if( _navAr != null ) 
		{
			// Update nav buttons current color
			var len:uint = _navAr.length;
			for ( var i:uint=0; i<len; i++ ) 
			{
				var btn:NavButtonMain_swc = _navAr[i];
				btn.updateColor();
			}
		}
	}
	
	// ______________________________________________________________ Updating Nav Status
	
	/** 
	*	Update the navigation button's status <br/>
	*	Note: this is also called by site.control.LoadNewSection.as
	*	
	*	@param		The array index of the section to be activated
	*/
	public function makeNavItemActive ( $index:uint ):void
	{	
		if( _currentBtn != null ) 
			_currentBtn.deselct();
		
		var btn:NavButtonMain_swc = _navAr[ $index ];
		btn.select();
				
		_currentBtn = btn;
	}
	
	// ______________________________________________________________ Getters / Settesr
	
	public function set navSprite ( $sprite:Sprite ):void{ _navSprite = $sprite; };
	
	// ______________________________________________________________ Event Handlers
	private function _handleNavBtnClick ( e:Event ):void { sendNotification( SiteFacade.NAV_BTN_CLICK, e.currentTarget.index ); 	}
	
	
}
}