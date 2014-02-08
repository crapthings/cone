Template['mobile-layout'].rendered = ->
	($ 'textarea').autosize() if ($ 'textarea').length
	($ '.timeago').timeago() if ($ '.timeago').length
	moment.lang('zh-cn')
