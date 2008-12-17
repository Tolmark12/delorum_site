package site.view.sections.portfolio_components.column_objects
{

import delorum.slides.*;

public class Slides extends BaseColumnObj implements IColumnObject
{
	
	public var imagesDir:String;
	private var _slideShow:SlideShow;
	private var _slideShowWidth:Number;
	
	public function Slides():void
	{
		super();
	}
	
	override public function make ( $node:XML ):void
	{
		var w:Number   = ( String( $node.@w  ).length == 0 )? 					508 	: $node.@w  ;
		var h:Number   = ( String( $node.@h  ).length == 0 )? 					351		: $node.@h  ;
		var dt:Number  = ( String( $node.@displayTime ).length == 0 )? 			6 		: $node.@displayTime ;
		var ats:Number = ( String( $node.@transitionSpeed).length == 0 )? 		4 		: $node.@transitionSpeed;
		var cts:Number = ( String( $node.@clickTransitionSpeed).length == 0 )? 	1 		: $node.@clickTransitionSpeed;
		var id:String  = ( String( $node.@id ).length == 0 )? 					null	: $node.@id ;
		
		_slideShowWidth = w;
		_slideShow = new SlideShow(	w, h, dt, ats, cts, id);

		this.addChild( _slideShow );
		var slideShowVo = new SlideShow_VO();
		slideShowVo.parseXml( new XMLList($node), imagesDir )
		_slideShow.buildSlideShow( slideShowVo );
		
		super.make($node);
		_fireHeightChange();
		_fireInitialized();
	}
	
	override public function get myWidth (  ):Number{ return _slideShowWidth; };

}

}