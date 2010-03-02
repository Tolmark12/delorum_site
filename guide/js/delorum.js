
// ABOUT-US: TEAM PAGE //

function showBio($who)
{
	$$('.bio').each(function(e){e.hide();});
	$($who + '-bio').appear();
	
	if(window.pageYOffset > 50)
	{
		$($who + '-bio').style.top = window.pageYOffset - 35 + 'px';
	}else{
		$($who + '-bio').style.top = window.pageYOffset + 'px';
	}	
}

// TOOLS //

function showTool($toolNumber)
{
	$$('.tool').each(function(e){e.hide();});
	$('tool-' + $toolNumber).appear();	
}

// CONTACT INFORMATION //
	
var timer;
var contactInfoIsSliding = false;

function showContactInfo()
{
	if(!contactInfoIsSliding)
	{	
		contactInfoIsSliding = true;
		new Effect.SlideDown('contact-info-wrapper', {duration:0.25, afterFinish:function(){createShield();}, queue: {position: 'front', scope: 'contact-info', limit: 1}});
		return false;
	}
}

function createShield()
{
	var div 				= document.createElement('div');

    var width 				= $('contact-info-wrapper').getWidth() + 10;
    var height 				= $('contact-info-wrapper').getHeight() + 10;

    div.style.width 		=  width + 'px';
	div.style.height 		=  height + 'px';

	div.style.margin		= '0px 0px 0px -5px';

	//div.style.background 	= "#FF0000";
	//div.style.MozOpacity 	= .5;
	
	$('contact-info-wrapper').appendChild(div);		
}

function startHideTimer()
{
	timer = setTimeout('hideContactInfo()', 5000);
}

function stopHideTimer()
{
	clearTimeout(timer);
}

function hideContactInfo()
{
	if(contactInfoIsSliding)
	{
		$('contact-info-wrapper').removeChild($('contact-info-wrapper').lastChild);
		new Effect.SlideUp('contact-info-wrapper', {duration:0.25, afterFinish:function(){contactInfoIsSliding = false;}, queue: {position: 'end', scope: 'contact-info', limit: 1}});
		return false;
	}
}