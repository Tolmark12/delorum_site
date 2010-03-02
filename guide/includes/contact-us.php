<span id='contact-btn' onClick='showContactInfo();'><a href='#'><span class='no-display'>contact</span></a></span>

<div id='contact-info-wrapper' class='wrapper' style='display:none;' onMouseOut='startHideTimer();' onMouseOver='stopHideTimer();'>
	<div id='contact-info-background' class=''>
		<div id='contact-info' class=''>
			<p class='white-text'><span class='bold'>Delorum Corp.</span> 22 N. 2nd E. Rexburg, ID 83440</p>
			<div class='vSpacer' style='height:15px;'>&nbsp;</div>
			<p class='brown-text'><span class='bold'>Idaho Office:</span> 208.359.1982</p>
			<p class='brown-text'><span class='bold'>Dallas Office:</span> 214.404.5227</p>
			<div class='vSpacer' style='height:25px;'>&nbsp;</div>
			<p class='brown-text'>For <span class='bold'>new business inquiries</span> contact Keith Nelson at 1.208.359.1982 or send an email to <a href='mailto:keithnelson@delorum.com' class='brown-text underline'>keith@delorum.com</a></p>
	
			<a href='#'><span id='contact-close-btn' class='green-text underline' onClick='hideContactInfo();'>close</span></a>
		</div>
	</div>
</div>

<?php $baseUrl = '/delorum_site/guide'; ?>

<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/prototype.js"></script>
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/scriptaculous/effects.js"></script>
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/delorum.js"></script>