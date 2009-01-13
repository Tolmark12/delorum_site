package site.view.sections.portfolio_components
{

import caurina.transitions.Tweener;
import flash.display.Sprite;

public class RowBase extends Sprite
{
	public function RowBase():void
	{
		
	}
	
	// ______________________________________________________________ API
	
	public function hide (  ):void
	{
		this.visible = false
		this.alpha = 0;
	}
	
	public function show (  ):void
	{
		if( this.visible == false ) {	
			Tweener.addTween( this, { alpha:1, time:0.4, transition:"EaseInOutQuint"} );
			this.visible = true;
		}
	}
	
	public function destruct (  ):void
	{
	}

}

}