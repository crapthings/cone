Template['backend-signin'].events
	'submit #signinForm':(e, t) ->
		e.preventDefault()
		options = form2js 'signinForm'
		Meteor.loginWithPassword options.username, options.password, (err) ->
			Router.go Router.routes['backend-my'].originalPath unless err
