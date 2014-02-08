Template['mobile-signin'].events
	'tap button[data-action="signin"]': (e, t) ->
		e.preventDefault()
		$username = ($ 'input[name="username"]').val()
		$password = ($ 'input[name="password"]').val()
		Meteor.loginWithPassword $username, $password, (err) ->
			unless err
				Router.go Router.routes['mobile-home'].path()
