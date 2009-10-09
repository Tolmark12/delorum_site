<?php
	$imgUrl = '/delorum_site/guide';
?>

<div id='' class='wrapper right-side-wrapper'>
	<div id='' class='right-side'>
		<?php include('contact-us.php'); ?>
		
		<div id='' class='case-studies'>
			<img src='<?php echo $imgUrl; ?>/images/right-side/trees.png' alt='trees'/>
			
			<div id='case-studies-flash-div' class=''>
				
			</div>
			
			<?php include('recent-news.php'); ?>
		</div>
	</div>
</div>

<script type="text/javascript" src="<?php echo $imgUrl; ?>/js/swfobject/swfobject.js"></script>
<script type="text/javascript">
    swfobject.embedSWF("<?php echo $imgUrl; ?>/flash/case-studies/case-studies.swf", "case-studies-flash-div", "215", "325", "9.0.0", "expressInstall.swf");
</script>