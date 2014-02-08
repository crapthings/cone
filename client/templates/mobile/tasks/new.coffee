Template['mobile-tasks-new'].events
	'tap button[type="submit"]': (e, t) ->
		options = form2js 'taskForm'
		Meteor.call 'newTask', options, (err) ->
			unless err
				Router.go Router.routes['mobile-tasks'].path()
