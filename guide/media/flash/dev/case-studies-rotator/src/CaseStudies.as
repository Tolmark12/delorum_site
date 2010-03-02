package 
{

import flash.display.Sprite;
import app.AppFacade;

public class CaseStudies extends Sprite
{
	public function CaseStudies():void
	{
		var myFacade:AppFacade = AppFacade.getInstance( 'app_facade' );
		myFacade.startup( this );
	}
}

}