Router.map ->
	@route 'backend-signin',
		layoutTemplate: 'backend-sign-layout'
		path: '/backend/signin'
		after: [
			->
				if Meteor.user()
					Router.go Router.routes['backend-my'].path()
		]

	@route 'backend-signup',
		layoutTemplate: 'backend-sign-layout'
		path: '/backend/signup'
