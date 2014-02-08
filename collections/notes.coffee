# db

@Notes = new Meteor.Collection 'notes'

# access

Notes.before.find (userId) -> return false unless userId
Notes.before.findOne (userId) -> return false unless userId
Notes.before.insert (userId) -> return false unless userId
Notes.before.update (userId) -> return false unless userId and isOwner userId
Notes.before.remove (userId) -> return false unless userId and isOwner userId

# hooks

Notes.before.insert (userId, note) ->
	_.extend note,
		creatorId: userId
		createdAt: new Date()
		timestamp: Date.now()

Notes.after.insert (userId) -> Users.update userId, $inc: 'stats.notes': 1
Notes.after.remove (userId) -> Users.update userId, $inc: 'stats.notes': -1

# methods

Meteor.methods

	newNote: (options) ->
		check options.content, Match.Optional String
		Notes.insert options

	removeNote: (noteId) ->
		check noteId, Match.Optional String
		Notes.remove noteId

# publish

if Meteor.isServer

	Meteor.publish 'myLatestNotes', ->
		Notes.find { creatorId: @userId },
			sort:
				timestamp: -1
