<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="description" content="Delorum Commerce - Helping you survive the world wild web." />
		<meta name="keywords" content=" " />
		
		<link rel="stylesheet" type="text/css" media="screen" href="../../css/styles.css" />
		
		<title>Delorum Commerce - Our Services: Flash</title>
	</head>
	
	<body>
		<div id='flash-page-wrapper' class='wrapper page-wrapper'>
			
			<!-- LEFT NAV -->
			<?php include('../../includes/left-nav.php'); ?>
			
			<!-- MAIN PAGE -->
			<div id='flash-main-page' class='page main-page'>
				
				<div id='flash-page-top' class='page-top'>
					<div id='flash-header' class='header'>
						<div id='flash-header-text' class='header-text'>
							<p><span class='header-text-title'>All that Glitters:</span> Sure, there’s a cool factor, but with over a decade of Flash development, we’ve got depth, too. What do you need? We can do that.</p>
						</div>
						<div id='flash-header-image' class='header-images services-header-image'>
							<div id='flash-flash-div'>
								<img src='../../media/images/pages/services/flash/image.png' alt=''/>
							</div>
						</div>
					</div>
				</div>
				
				<div id='flash-page-background' class='page-background'>
					<div id='flash-page-content-wrapper' class='wrapper page-content-wrapper'>

						<div class='dotted-short'></div>

						<div id='flash-page-body' class='page-body services-page-body'>
							<div id='flash-content-body' class='content-body services-content-body'>
								<div id='flash-content-left' class='content-left services-content-left'>
									<h4><span class='uppercase brown-text bold'>we can build anything</span></h4>
									<div id='flash-content-left-body' class='content-left-body services-content-left-body'>
										<p>We offer extensive Flash capabilities, but usually guide clientele with this admonition: Know when to use it. Typically, that means we integrate Flash elements as part of a Magento HTML site, which allows sophisticated movement and functionality without impacting search engine optimization.</p>
										<p>However, there are occasions when a full Flash implementation is preferable. Generally, this is the case when brand or technical requirements simply can’t be met by today’s HTML, and searchability is a lesser priority. We’ve even created a Magento Flash module linking a Magento admin to a full Flash front end. No matter what your needs, we’ve got the Flash expertise to build ANYTHING.</p>
									</div>
								</div>
					
								<div id='flash-content-right' class='content-right services-content-right'>
									<div id='flash-services-list' class='services-list light-green-text'>
										<h4><span class='uppercase green-text'>services:</span></h4>
										<div id='services' class='capitalize italic bold'>
											<ul>
												<li>actionscript 3</li>
												<li>magento-driven flash</li>
												<li>modular architecture</li>
												<li>administrable content</li>
												<li>design</li>
												<li>interactivity</li>
											</ul>
										</div>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div id='flash-page-bottom' class='page-bottom'></div>
				
				<!-- BOTTOM NAV -->
				<?php include('../../includes/bottom-nav.php'); ?>
			</div>
			
			<!-- MAIN NAV -->
			<?php include('../../includes/main-nav.php'); ?>
			
			<!-- RIGHT SIDE -->
			<?php include('../../includes/case-studies.php'); ?>
		</div>
		
	</body>
	
	<?php
		$baseUrl = '/delorum_site/guide';
		$mediaUrl = '/delorum_site/guide/media';	
	?>
	
	<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/swfobject/swfobject.js"></script>
	
	<script type="text/javascript">
		flashVars 	= {};
		flashParams = {};
	    swfobject.embedSWF("<?php echo $mediaUrl; ?>/flash/dev/services/flash/src/main.swf", "flash-flash-div", "520", "222", "9.0.0", "expressInstall.swf", flashVars, flashParams);
	</script>
	
</html>