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
		super.make($node);
		_slideShowWidth = Number( $node.@w );
		_slideShow = new SlideShow(	_slideShowWidth,
		 		   				 	Number( $node.@h), 
				   				 	Number( $node.@displayTime ),
								 	Number( $node.@transitionSpeed ), 
								   	$node.@id );

		this.addChild( _slideShow );
		var slideShowVo = new SlideShow_VO();
		slideShowVo.parseXml( new XMLList($node), imagesDir )
		_slideShow.buildSlideShow( slideShowVo );
		_fireHeightChange();
	}
	
	override public function get myWidth (  ):Number{ return _slideShowWidth; };

}

}