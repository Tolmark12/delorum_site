<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
    <head>
        <title>Delorum Design</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<script type="text/javascript" src="js/functions.js"></script>
		<script type="text/javascript" src="js/swfIN.js"></script>
		<link rel="stylesheet" href="style.css" type="text/css" media="screen" charset="utf-8">
    </head>

    <body id="body" onLoad="setBgColor('#' + defaultColor);">
		<!-- SEO -->
		<div id="seo">
			Delorum is a design and development firm specializing in branding and rich online experience.
		</div>
		
		<!-- Flash -->
        <div id="flash_wrapper">
			
			<script type="text/javascript">
	            /* <![CDATA[ */
	
					// Background color
					defaultColor = "454240";
					
					// Flash creation
					var swf = new swfIN("DelorumSite.swf", "delorum_flash", "100%", "100%");
					swf.useExpressInstall("js/xi.swf", 300, 300);
					swr.useMacMousewheel();
					
					// Vars
					swf.addVars( {
						xmlPath			: "content/xml/site.xml",
						defaultColor	: "0x" + defaultColor
					} );
					
					// Params
					swf.addParam("bgcolor", 			"#" + defaultColor);
					swf.addParam("menu", 				"false");
					swf.addParam("allowfullscreen", 	"true");
					swf.detectShowDiv( [9,0,45], 		"no_flash" );
					
					// SEO + Make
					swf.hideSEO("seo");
					swf.write();	
					
	            /* ]]> */
	        </script>
			
			<!-- No Flash -->
            <div id="no_flash" >
                <p>In order to view this page you need Flash Player 9+ support. Click on the following link to download it.</p>
                <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
            </div>
        </div>


		<!-- Analytics -->
		<script type="text/javascript">
		 /* <![CDATA[ */
			// Other
			var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
			document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
			// Page tracker
			var pageTracker = _gat._getTracker("UA-760419-2");
			pageTracker._trackPageview();
		/* ]]> */
		</script>	
    </body>
</html>

