Router.map ->
	@route 'usersManagement',
		path: '/backend/managements/users'

		data: ->
			users: Users.find {},
				sort:
					timestamp: -1

	@route 'newUser',
		path: '/backend/managements/users/new'

	@route 'editUser',
		path: '/backend/managements/users/:_id/edit'
