<?php
	$mediaUrl = '/delorum_site/guide';
?>

<div id='' class='wrapper right-side-wrapper'>
	<div id='' class='right-side'>
		<?php include('contact-us.php'); ?>
		
		<div id='' class='case-studies'>
			<img src='<?php echo $mediaUrl; ?>/images/right-side/trees.png' alt='trees'/>
			
			<script type="text/javascript" src="<?php echo $mediaUrl; ?>/js/swfobject/swfobject.js"></script>
			<script type="text/javascript">
	            swfobject.embedSWF("http://192.168.1.20/delorum_site/guide/flash/case-studies/case-studies.swf", "flash-div", "350", "200", "9.0.0", "http://192.168.1.20/delorum_site/guide/js/swfobject/expressInstall.swf");
	        </script>
			
			<?php include('recent-news.php'); ?>
		</div>
	</div>
</div>