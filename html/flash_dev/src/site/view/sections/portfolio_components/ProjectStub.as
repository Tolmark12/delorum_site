package site.view.sections.portfolio_components
{
import site.model.vo.*;
import delorum.loading.ImageLoader;
import flash.display.Sprite;
import caurina.transitions.Tweener;
import flash.events.*;
import flash.filters.*;
import gs.TweenLite;
import DelorumSite;

public class ProjectStub extends Sprite
{
	
	public static var currentProject:ProjectStub;
	
	// Events
	public static const ACTIVATE_STUB:String = "activate_stub";
	public static const DE_ACTIVATE_STUB:String = "de_activate_stub";	
	public static const CONTENT_HEIGHT_CHANGED:String 	= "content_height_changed";
	
	private var _clickEvent:String;			// Which notification to fire on click
	
	
	// Physical characteristics
	public static const BORDER_SIZE:Number  = 0;
	public static const WIDTH_TINY:Number 	= 224;	// These are the widths of the images at the
	public static const WIDTH_SMALL:Number 	= 224;	// These are the widths of the images at the
	public static const WIDTH_MEDIUM:Number	= 700;	// various screen resolutions. Small is when closed.
	public static const WIDTH_LARGE:Number 	= 800;	// Medium is when browser < 1000 px. Large when > 1000px
	
	public static const HEIGHT:Number	 	= 243;	
	public static const HEIGHT_TINY:Number  = 50;
	
	// Physical states
	public static const TINY:String 		= "tiny";
	public static const SMALL:String 		= "small";
	public static const MEDIUM:String 		= "medium";
	public static const LARGE:String 		= "large";
	
	// Graphic
	private var _vo:ProjectStub_VO;
	private var _stubMc:Sprite;
	private var _bgMc:Sprite;
	private var _imageMc:Sprite;
	private var _maskMc:Sprite;
	private var _bgMcHolder:Sprite;
	private var _holder:Sprite;
	
	// State
	private var _sizeState:String;
	private var _state:String;
	
	// Identification
	private var _arrayIndex:uint;
	
	// Color / B+W effects
	public var rLum:Number = 0;
	public var gLum:Number = 0;
	public var bLum:Number = 0; 
	public var rLum2:Number = 1;
	public var gLum2:Number = 1;
	public var bLum2:Number = 1;
	public var brightness:Number = 0;
	
	// Motion
	private var _targetX:Number;
	private var _baseX:Number = -400;
	
	// Project Details
//	private var _details:ProjectDetails;
	
	public function ProjectStub( ):void
	{
		_sizeState = SMALL;
	}
	
	// ______________________________________________________________ Make
	
	/**	
	*	Initialize the holder sprites
	*	
	*	@param		The main holder sprite
	*	@param		Contains all the data
	*/
	public function make ( $vo:ProjectStub_VO  ):void
	{
		_vo			= $vo;
		_baseX		= -$vo.frameX;
		_arrayIndex = $vo.arrayIndex;
		_stubMc		= new Sprite();
		_bgMc 		= new Sprite();
		_bgMcHolder	= new Sprite();
		_imageMc	= new Sprite();
		_maskMc		= new Sprite();
		_holder		= new Sprite();
		
		_bgMc.x 			= -BORDER_SIZE;
		_bgMc.y 			= -BORDER_SIZE;
		
		this.visible 		= false;
		_stubMc.buttonMode  = true;
		_stubMc.addEventListener(  MouseEvent.MOUSE_OVER, _mouseOver);
		_stubMc.addEventListener(  MouseEvent.MOUSE_OUT , _mouseOut );
		_stubMc.addEventListener(  MouseEvent.CLICK ,     _click );
		_clickEvent = ACTIVATE_STUB;
		
		this.addChild(	 		_holder		);
		_holder.addChild( 		_stubMc   	);
		_stubMc.addChild( 		_bgMcHolder );
		_stubMc.addChild( 		_imageMc  	);
		_holder.addChild( 		_maskMc   	);
		_bgMcHolder.addChild( 	_bgMc 		);
		
		//makeDetailsMc( $vo );
		
		_loadImage( $vo.image );
		_drawBgAndMask();
		//_drawDropShadow();
	}
	
	private function _drawDropShadow (  ):void
	{
		var color:Number = 0x000000;
		var angle:Number = 45;
		var alpha:Number = 0.8;
		var blurX:Number = 8;
		var blurY:Number = 8;
		var distance:Number = 5;
		var strength:Number = 0.45;
		var inner:Boolean = false;
		var knockout:Boolean = false;
		var quality:Number = BitmapFilterQuality.LOW;
		var dsf:DropShadowFilter = new DropShadowFilter(distance,angle,color,alpha,blurX,blurY,strength,quality,inner,knockout);
		_bgMcHolder.filters = [dsf];
	}
	
	public function makeDetailsMc ( $vo:ProjectStub_VO ):void
	{
//		_details 			= new ProjectDetails();
//		_details.body  		= $vo.shortDescription;
//		_details.title 		= $vo.title;
//		_details.slideShow 	= $vo.slideShow;
//		_details.y 			= 300;
//		_details.addEventListener( ProjectDetails.LOAD_PROJECT_XML, _fireLoadXmlEvent 	);
//		_details.addEventListener( CONTENT_HEIGHT_CHANGED, _fireHeightChangeEvent 		);
//		this.addChild( _details  );
	}
	
	public function removeDetailsMc ( $detailsMc:ProjectDetails ):void
	{
//		$detailsMc.removeEventListener( ProjectDetails.LOAD_PROJECT_XML, _fireLoadXmlEvent 	);
//		$detailsMc.removeEventListener( CONTENT_HEIGHT_CHANGED, _fireHeightChangeEvent 		);
//		this.removeChild( $detailsMc );
//		if( $detailsMc == _details ) 
//			_details = null;
	}
	
	private function _drawBgAndMask (  ):void
	{
		
		_bgMc.graphics.beginFill( 0xFFFFFF );
		if( BORDER_SIZE != 0)
			_bgMc.graphics.drawRect(0,0,WIDTH_SMALL + BORDER_SIZE*2, HEIGHT + BORDER_SIZE*2 )
		_maskMc.graphics.beginFill( 0xFFFFFF );
		_maskMc.graphics.drawRect(0,0,WIDTH_SMALL, HEIGHT );
	}
	
	private function _loadImage ( $imagePath:String ):void
	{
		var ldr:ImageLoader = new ImageLoader( $imagePath, _imageMc );
		ldr.onComplete	= _initImage;
		ldr.addItemToLoadQueue();		
	}
	
	private function _initImage ( e:Event ):void
	{
		_imageMc.mask = _maskMc;
		this.alpha = 0;
		this.visible = true;
		Tweener.addTween( this, { alpha:1, time:0.3, transition:"EaseInQuint"} );
		_imageMc.x = _baseX;
	}
	
	// ______________________________________________________________ Activating content
	
	public function buildPage ( $page:Page_VO ):void
	{
//		_details.buildPage( $page );
	}
	
	// ______________________________________________________________ Color effects
	
	/**	Turns the image to black and white */
	public function dimImage ( $changeBorderToo:Boolean = true ):void
	{
		Tweener.addTween( this, { rLum:0.2225,  gLum:0.7169,  bLum:0.0606,
								  rLum2:0.2225, gLum2:0.7169, bLum2:0.0606, brightness:-120,
								  time:0.4, transition:"EaseOutQuint", onUpdate:_updateImageSaturation} );

		if( $changeBorderToo ) 
			changeBorderColor(DelorumSite.GRAY_STUB);
	}
	
	/**	Turns the image back to color */
	public function brightenImage ( $changeBorderToo:Boolean = true, $lum2:Number = 1 ):void
	{
		Tweener.addTween( this, { rLum:0, gLum:0, bLum:0, rLum2:$lum2, gLum2:$lum2, bLum2:$lum2, brightness:0,  
								  time:.3, transition:"EaseOutQuint", onUpdate:_updateImageSaturation} );
		if( $changeBorderToo ) 
			changeBorderColor(DelorumSite.WHITE);
	}
	
	/**	
	*	Tween the border color
	*	
	*	@param		Color to tween to
	*/
	public function changeBorderColor ( $color:Number ):void
	{
		TweenLite.to(_bgMc, 0.5, { tint:$color });
		
	}
	
	// Called on tween update, see dimImage / brightenImage
	private function _updateImageSaturation (  ):void
	{
		// change image color / B&W											   // Basic matrix with no effects
	 	var colorMatrix:Array = [ 	rLum2, gLum,  bLum,  0,  brightness,       // colormatrix = colormatrix.concat([1, 0, 0, 0, 0];
		               	 			rLum,  gLum2, bLum,  0,  brightness,       // colormatrix = colormatrix.concat([0, 1, 0, 0, 0];
		               	 			rLum,  gLum,  bLum2, 0,  brightness,       // colormatrix = colormatrix.concat([0, 0, 1, 0, 0];
		               	 			0, 0, 0, 1, 0 ];                           // colormatrix = colormatrix.concat([0, 0, 0, 1, 0];
		
		var filter:ColorMatrixFilter = new ColorMatrixFilter(colorMatrix);
		_imageMc.filters = [ filter ];
	}
	
	// ______________________________________________________________ Positioning + Activating and Deactivating
	
	/** 
	*	Set the state of the stub. This also activates / dactivates it
	*	
	*	@param		The state. (SMALL, MEDIUM, LARGE)
	*/
	public function setState ( $state:String ):void
	{
		if( _sizeState != $state ) 
		{
			var completeHandler:Function = null;
			_sizeState = $state;
			
			// Showing / Hiding details
			if( _sizeState == SMALL || _sizeState == TINY ){
				_clickEvent = ACTIVATE_STUB;
//				if( _details != null ) 
//					_details.hide();
			}
			else if( currentProject != this ) {
				_clickEvent = DE_ACTIVATE_STUB;
//				makeDetailsMc( _vo );
//				completeHandler = _details.show;
				currentProject = this;
			}
			
			var xtarg:Number = (_sizeState == SMALL)? _baseX : 0;
			Tweener.addTween( _bgMc,    {width:stubWidth + BORDER_SIZE, time:1, transition:"EaseInOutQuint", onComplete:completeHandler});
			Tweener.addTween( _maskMc,  {width:stubWidth - BORDER_SIZE, time:1, transition:"EaseInOutQuint"});
			Tweener.addTween( _imageMc, {x:xtarg, time:1, transition:"EaseInOutQuint"} );
		}
	}
	
	/**	The position to move the stub to
	*	
	*	@param		X position
	*	@param		Y Position
 	*/
	public function moveTo ( $x:Number, $y:Number ):void
	{
		if( this.visible == true ) 
			Tweener.addTween( this, { x:$x, y:$y, time:1, transition:"EaseInOutQuint"} );
		else
			this.x = $x;
		_targetX = $x;
	}

	/**	Bring this stub in front of all other stubs */
	public function bringToFront (  ):void
	{
		this.parent.setChildIndex( this, this.parent.numChildren - 1);
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _mouseOver ( e:Event ):void
	{
		if ( currentProject == null ){
			Tweener.addTween( this, { time:0.1, onComplete:bringToFront} );
			changeBorderColor( DelorumSite.TAN );
		}else if ( currentProject != this ) {
			brightenImage( false );
		}
	}
	
	private function _mouseOut ( e:Event ):void
	{
		if( currentProject == null ){
			changeBorderColor( DelorumSite.WHITE );
		}else if( currentProject != this ) {
			dimImage( false );
		}
	}
	
	private function _click ( e:Event ):void
	{
		this.dispatchEvent( new Event( _clickEvent ) );
	}
	
	private function _fireLoadXmlEvent ( e:Event ):void
	{
		this.dispatchEvent( new Event( ProjectDetails.LOAD_PROJECT_XML ) );
	}
	
	private function _fireHeightChangeEvent ( e:Event ):void
	{
		this.dispatchEvent( new Event( CONTENT_HEIGHT_CHANGED ) );
	}
	
	// ______________________________________________________________ Getters / Setters
	
	public function get stubWidth 	(  ):Number	{ return ProjectStub["WIDTH_" + _sizeState.toUpperCase() ] + BORDER_SIZE; };
	public function get stubHeight 	(  ):Number	{ 
		return (_sizeState == TINY)? HEIGHT_TINY : HEIGHT; 
	}

	public function get arrayIndex 	(  ):uint	{ return _arrayIndex; };
	public function get targetX 	(  ):Number	{ return _targetX; };
	public function get sprite      (  ):Sprite { return this; };
	public function get state 		(  ):String { return _state; };
	public function get vo 			(  ):ProjectStub_VO{ return _vo; };
}

}