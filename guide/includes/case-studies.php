<?php
	$baseUrl = '/delorum_site/guide';
	$mediaUrl = '/delorum_site/guide/media';	
?>

<div id='' class='wrapper right-side-wrapper'>
	<div id='' class='right-side'>
		<?php include('contact-us.php'); ?>
		
		<div id='' class='case-studies'>
			
			<div id='stars-flash-div' class=''>
				<img src='' alt=''>
			</div>
			
			<div id='case-studies-flash-div' class=''>
				<img src='' alt=''>
			</div>
			
			<?php include('recent-news.php'); ?>
		</div>
	</div>
</div>

<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/swfobject/swfobject.js"></script>

<script type="text/javascript">
	flashVars 	= {};
	flashParams = { wmode:"transparent"};
    swfobject.embedSWF("<?php echo $mediaUrl; ?>/flash/dev/stars/stars.swf", "stars-flash-div", "218", "154", "9.0.0", "expressInstall.swf", flashVars, flashParams);
</script>

<script type="text/javascript">
	flashVars   = { configData:"http://www.delorum.com/delorum_site/guide/media/flash/dev/case-studies-rotator/content/json/Config.json"};
	flashParams = { wmode:"transparent"};
    swfobject.embedSWF("<?php echo $mediaUrl; ?>/flash/dev/case-studies-rotator/case-studies.swf", "case-studies-flash-div", "215", "325", "9.0.0", "expressInstall.swf", flashVars, flashParams);
</script>