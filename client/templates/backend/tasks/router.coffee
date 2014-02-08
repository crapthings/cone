Router.map ->
	@route 'backend-tasks',
		path: '/backend/tasks'

		data: ->
			page:
				title: '任务'

			urgency: Tasks.find { completed: false, urgency: true, close: { $exists: false } },
				sort:
					timestamp: -1
				limit: 5

			uncompleted: Tasks.find { completed: false, urgency: { $exists: false }, close: { $exists: false } },
				sort:
					timestamp: -1
				limit: 5

		before: [
			->
				@subscribe('uncompletedTasksList').wait()
		]

	@route 'backend-tasks-uncompleted',
		path: '/backend/tasks/uncompleted'

		data: ->
			page:
				title: '未完成'
			uncompleted: Tasks.find { completed: false },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('uncompletedTasksList').wait()
		]

	@route 'backend-tasks-completed',
		path: '/backend/tasks/completed'

		data: ->
			page:
				title: '已完成'
			completed: Tasks.find { completed: true },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('completedTasksList').wait()
		]

	@route 'backend-tasks-closed',
		path: '/backend/tasks/closed'

		data: ->
			page:
				title: '已关闭'
			closed: Tasks.find { closed: true },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('closedTasksList').wait()
		]

	@route 'backend-tasks-urgency',
		path: '/backend/tasks/urgency'

		data: ->
			page:
				title: '紧急'
			urgency: Tasks.find { urgency: true },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('urgencyTasksList').wait()
		]

	@route 'taskView',
		path: '/backend/my/tasks/:_id/view'

		data: ->
			page:
				title: '查看任务'

			task: Tasks.findOne @params._id

			taskComments: Comments.find { taskId: @params._id },
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('task', @params._id).wait()
				@subscribe('taskComments', @params._id)
		]
