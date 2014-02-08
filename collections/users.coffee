# db

@Users = Meteor.users

Users._transform = (user) ->
	_.extend user,
		displayName: user.profile.name or user.username
		profile:
			avatarUrl: user.profile.avatarUrl or 'avatar-default.gif'

# before

Users.before.insert (userId, user) ->
	if user.username is 'admin' or user.username is 'crapthings'
		user.role = 'administrator'
	else
		user.role = 'user'

Users.before.insert (userId, user) ->
	_.extend user,
		profile: user.profile or {}

# after

Users.after.insert ->
	System.update { system: true },
		$inc:
			'stats.users': 1

Users.after.remove ->
	System.update { system: true },
		$inc:
			'stats.users': -1

# methods

Meteor.methods
	newUser: (options) ->
		Accounts.createUser options

	removeUser: (userId) ->
		Users.remove userId

	updateUserProfile: (options) ->
		console.log options
		Users.update @userId,
			$set:
				profile: options

# server

if Meteor.isServer

	# publish

	Meteor.publish '', ->
		if @userId
			Users.find { _id: @userId },
				fields:
					services: false

	Meteor.publish '', ->
		if @userId
			Users.find {},
				fields:
					services: false
