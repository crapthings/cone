Router.map ->
	@route 'mobile-tasks',
		layoutTemplate: 'mobile-layout'

		path: '/mobile/tasks'

		data: ->
			uncompleted: Tasks.find { completed: false, urgency: { $exists: false } },
				sort:
					timestamp: -1

			urgency: Tasks.find { completed: false, urgency: true },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('uncompletedTasksList').wait()
				@subscribe('urgencyTasksList').wait()
		]

	@route 'mobile-tasks-new',
		layoutTemplate: 'mobile-layout'
		path: '/mobile/tasks/new'
