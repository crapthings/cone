Template['mobile-topnav'].events
	'tap .toggle-menu': (e, t) ->
		$layout = ($ '#mobile-layout-wrapper')
		unless $layout.hasClass 'open-menu'
			$layout.addClass 'open-menu'
		else
			$layout.removeClass 'open-menu'
