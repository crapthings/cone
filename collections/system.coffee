@System = new Meteor.Collection 'system'

Meteor.methods

	recalcUsers: ->
		__counts = Users.find().count()
		System.update { system: true },
			$set:
				'stats.users': __counts

	recalcNotes: ->
		__counts = Notes.find({ creatorId: Meteor.userId() }).count()
		Users.update Meteor.userId(),
			$set:
				'stats.notes': __counts

	recalcUncompletedTasks: ->
		__counts = Tasks.find({ completed: false }).count()
		System.update { system: true },
			$set:
				'stats.tasks.uncompleted': __counts

	recalcCompletedTasks: ->
		__counts = Tasks.find({ completed: true }).count()
		System.update { system: true },
			$set:
				'stats.tasks.completed': __counts

	recalcClosedTasks: ->
		__counts = Tasks.find({ closed: true }).count()
		System.update { system: true },
			$set:
				'stats.tasks.closed': __counts

	recalcUrgencyTasks: ->
		__counts = Tasks.find({ urgency: true }).count()
		System.update { system: true },
			$set:
				'stats.tasks.urgency': __counts

if Meteor.isServer

	Meteor.publish '', ->
		if @userId
			System.find { system: true }
