<?php
	$baseUrl = '/delorum_site/guide/js';
	$mediaUrl = '/delorum_site/guide/media';
?>

<div id='' class='wrapper right-side-wrapper'>
	<div id='' class='right-side'>
		<?php include('contact-us.php'); ?>
		
		<div id='' class='case-studies'>
			<img src='<?php echo $mediaUrl; ?>/images/right-side/trees.png' alt='trees'/>
			
			<div id='case-studies-flash-div' class=''>
				
			</div>
			
			<?php include('recent-news.php'); ?>
		</div>
	</div>
</div>

<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/swfobject/swfobject.js"></script>
<script type="text/javascript">
	flashVars   = { configData:"<?php echo $mediaUrl ?>/flash/case-studies/content/json/case-studies.json"};
	flashParams = { wmode:"transparent"};
    swfobject.embedSWF("<?php echo $mediaUrl; ?>/flash/case-studies/case-studies.swf", "case-studies-flash-div", "215", "325", "9.0.0", "expressInstall.swf", flashVars, flashParams);
</script>