window.onresize = detectResize;
window.onscroll = detectScroll;
echoString = "";
oldPercent = -1;


function detectResize(){
	//if( typeof( window.innerWidth ) != 'number' ){ 
		document.getElementById('delorum_flash').style.height = _innerHeight() + "px";
	//}
}

// ______________________________________________________________ Flash Scrolling

/** 
 * Formulate percent of document currently
 * being viewed in document window.
 * Pass value to flash for auto-scroll of flash document.
 * Value must be 0-1
 */
function detectScroll(){
	var percent = _scrollTop() / ( _scrollHeight() - _innerHeight() );
	if(oldPercent != percent)
	{
		if(percent >= 0){
			oldPercent = percent;
			getFlash().scrollFlash( percent, 0 );
		} 
	}
}

//window.onunload = _refreshHandler;
//function _refreshHandler()
//{
//	alert( (document.all)? document.body.scrollTop : window.pageYOffset );
//}

/**
 * Return the top os the scroll
 */
function _scrollTop()
{
	if (document.documentElement && document.documentElement.scrollTop)
		return document.documentElement.scrollTop;
	else if (document.body && document.body.scrollTop)
		return document.body.scrollTop;
	else
		return 0;
}

/**
 * Return the scroll height
 */
function _scrollHeight()
{
	if (document.documentElement && document.documentElement.scrollHeight)
		return document.documentElement.scrollHeight;
	else if (document.body && document.body.scrollHeight)
		return document.body.scrollHeight;
	else
		return 0;
}

function _innerHeight() {
	// Non-IE
	if( typeof( window.innerWidth ) == 'number' ) 
    	return window.innerHeight;
	// IE 6+ in 'standards compliant mode'
	else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) )
		return document.documentElement.clientHeight;
	// IE 4 compatible
	else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) )
		return document.body.clientHeight;
	else
		return 0;
}

// ______________________________________________________________ Get Flash swf

/** returns a reference to the swf */
function getFlash(){
	if (navigator.appName.indexOf("Microsoft") != -1) {
	    return window["delorum_flash"];
	} else {
	    return document["delorum_flash"];
	}
}


// ______________________________________________________________ Methods called by flash

/**
 * Called by flash. 
 * Sets the height of the body to the height of flash's content.
 */
function setFlashHeight( newHeight ){
	document.getElementById( "body" ).style.height = newHeight + "px";
	
	//alert(newHeight + ' : ' + _scrollHeight());
	
	if ( newHeight<_scrollHeight()  ) 
	{
		getFlash().scrollFlash( 0, 1 );
	}
}

function setBgColor( newBgColor ){
	document.getElementById( "delorum_flash" ).style.backgroundColor = newBgColor;
	//alert(document.getElementById( "flash_wrapper" ));
}

function moveScrollToCoordinate(y) { 
	window.scrollTo(0,y); 
}

function getScrollCordinate () {
	return (document.all)? document.body.scrollTop : window.pageYOffset ;
}


detectResize();


