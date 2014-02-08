Accounts.onCreateUser (options, user) ->
	_.extend user,
		profile: options.profile or {}

Meteor.startup ->

	isFirstUserExist = App.isDocExist Users, { username: 'admin' }

	unless isFirstUserExist

		Accounts.createUser
			username: 'admin'
			password: 'admin'
			profile:
				name: 'administrator'
