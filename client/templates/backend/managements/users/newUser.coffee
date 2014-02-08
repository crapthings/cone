Template.newUser.events
	'submit form': (e, t) ->
		options = form2js 'userForm'
		Meteor.call 'newUser', options, (err) ->
			unless err
				Router.go Router.routes['usersManagement'].path()
