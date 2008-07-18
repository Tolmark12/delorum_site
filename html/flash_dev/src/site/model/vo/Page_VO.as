package site.model.vo
{

public class Page_VO
{
	public var rowsAr:Array;	// An array of Row_VO value objects
	public var imagesDir:String;
	
	
	/** 
	*	Sets the images directory,
	*	
	*	@param		The Base directory
	*	@param		This directory is inside the base. If you want to use absolute urls
	*				with your images, pass $imagesDir as "false" or "absolute"
	*/
	public function setImagesDir ( $baseDir:String, $imagesDir:String ):void 
	{ 
		imagesDir = ($imagesDir == "absolute" || $imagesDir == false)? "" : $baseDir + $imagesDir; 
	}
}

}