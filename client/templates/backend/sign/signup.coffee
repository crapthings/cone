Template['backend-signup'].events
	'submit #signupForm': (e, t) ->
		e.preventDefault()
		options = form2js 'signupForm'
		Accounts.createUser options, (err) ->
			Router.go Router.routes['myUncompletedTasks'].originalPath unless err
