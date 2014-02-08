Template.layout.rendered = ->
	$niceScroll = ($ '#page').niceScroll()
	($ 'textarea').autosize() if ($ 'textarea').length
	($ '.timeago').timeago() if ($ '.timeago').length
	moment.lang('zh-cn')
