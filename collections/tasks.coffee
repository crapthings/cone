# db

@Tasks = new Meteor.Collection 'tasks',
	transform: (task) ->
		_.extend task,
			creator: Users.findOne task.creatorId

# before

Tasks.before.find (userId) -> return false unless userId
Tasks.before.insert (userId) -> return false unless userId

Tasks.before.insert (userId, task) ->
	_.extend task,
		completed: false
		creatorId: userId
		createdAt: new Date()
		timestamp: Date.now()
		stats:
			comments: 0

Tasks.after.insert ->
	System.update { system: true },
		$inc:
			'stats.tasks.uncompleted': 1

Tasks.after.update (userId, task, fieldNames, modifier, options) ->
	if @previous.completed is false and task.completed is true
		System.update { system: true },
			$inc:
				'stats.tasks.uncompleted': -1
				'stats.tasks.completed': 1

	if @previous.completed is true and task.completed is false
		System.update { system: true },
			$inc:
				'stats.tasks.uncompleted': 1
				'stats.tasks.completed': -1

Tasks.after.update (userId, task, fieldNames, modifier, options) ->
	if not @previous.urgency? and task.urgency
		System.update { system: true },
			$inc:
				'stats.tasks.urgency': 1

	if not task.urgency? and @previous.urgency
		System.update { system: true },
			$inc:
				'stats.tasks.urgency': -1

Tasks.after.update (userId, task, fieldNames, modifier, options) ->
	if not @previous.closed? and task.closed
		System.update { system: true },
			$inc:
				'stats.tasks.closed': 1

	if not task.closed? and @previous.closed
		System.update { system: true },
			$inc:
				'stats.tasks.closed': -1

Tasks.after.remove (userId, task) ->
	if task.completed is false
		System.update { system: true },
			$inc:
				'stats.tasks.uncompleted': -1

	if task.completed is true
		System.update { system: true },
			$inc:
				'stats.tasks.completed': -1

	if task.urgency?
		System.update { system: true },
			$inc:
				'stats.tasks.urgency': -1

	if task.closed?
		System.update { system: true },
			$inc:
				'stats.tasks.closed': -1

# methods

Meteor.methods

	newTask: (options) ->
		Tasks.insert options

	removeTask: (taskId) ->
		Tasks.remove taskId

	completeTask: (taskId) ->
		Tasks.update taskId,
			$set:
				completed: true
				completedAt: new Date()
				timestamp: Date.now()
			$unset:
				urgency: ''
				closed: ''

	uncompleteTask: (taskId) ->
		Tasks.update taskId,
			$set:
				completed: false
				timestamp: Date.now()

	urgencyTask: (taskId) ->
		Tasks.update taskId,
			$set:
				urgency: true
				timestamp: Date.now()
			$unset:
				closed: ''

	unurgencyTask: (taskId) ->
		Tasks.update taskId,
			$unset:
				urgency: ''

	closeTask: (taskId) ->
		Tasks.update taskId,
			$set:
				closed: true
				closedAt: new Date()
				timestamp: Date.now()
			$unset:
				urgency: ''

	uncloseTask: (taskId) ->
		Tasks.update taskId,
			$unset:
				closed: ''

# server

if Meteor.isServer

	# publish

	Meteor.publish 'uncompletedTasksList', ->
		if @userId
			Tasks.find { completed: false, closed: { $exists: false } },
				sort:
					timestamp: -1

	Meteor.publish 'completedTasksList', ->
		if @userId
			Tasks.find { completed: true },
				sort:
					timestamp: -1

	Meteor.publish 'closedTasksList', ->
		if @userId
			Tasks.find { closed: true },
				sort:
					timestamp: -1

	Meteor.publish 'urgencyTasksList', ->
		if @userId
			Tasks.find { completed: false, urgency: true },
				sort:
					timestamp: -1

	Meteor.publish 'task', (taskId) ->
		if @userId
			Tasks.find { _id: taskId }
