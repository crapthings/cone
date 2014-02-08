# db

@Comments = new Meteor.Collection 'comments',
	transform: (comment) ->
		_.extend comment,
			creator: Users.findOne comment.creatorId

Comments.before.insert (userId, comment) ->
	_.extend comment,
		createdAt: new Date()
		timestamp: Date.now()
		creatorId: userId

Comments.after.insert (userId, comment) ->
	Tasks.update comment.taskId,
		$inc:
			'stats.comments': 1

Meteor.methods

	newComment: (taskId, options) ->
		check taskId, Match.Optional String
		check options, Match.Optional Object
		_.extend options,
			taskId: taskId
		Comments.insert options

if Meteor.isServer

	Meteor.publish 'taskComments', (taskId) ->
		check taskId, Match.Optional String
		Comments.find { taskId: taskId },
			sort:
				timestamp: -1
