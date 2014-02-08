exports = @

@App = {}

App.login = App.signin = Meteor.loginWithPassword
App.logout = App.signout = Meteor.logout

@isDocExist = (collection, options) ->
	return collection.findOne options

@isOwner = (userId) ->
	return true if userId is Meteor.userId()

if Meteor.isClient

	@isUserLoggedIn = ->
		return true if Meteor.userId()

	App.resetForm = (t) ->
		($ t.find '.reset').trigger 'click'
		($ t.find 'textarea').height 'auto'

	App.logout = ->
		Meteor.logout (err) ->
			unless err
				Router.go '/'

App.isDocExist = (collection, options) ->
	return collection.findOne options

App.isLoggedIn = -> return true if Meteor.user()

App.isDocExist = (collection, options) -> return collection.findOne options

class App.Collection

	constructor: (collectionName) ->

		# initialize a collection

		collection = null

		_capitalizeCollectionName = collectionName.capitalize()
		_singularizeCollectionName = collectionName.singularize()

		exports[_capitalizeCollectionName] = collection = new Meteor.Collection collectionName,
			transform: (doc) ->
				_.extend doc,
					creator: Meteor.users.findOne doc.creatorId

		# collection hooks

		collection.before.find (userId) -> return false if userId
		collection.before.findOne (userId) -> return false if userId
		collection.before.insert (userId) -> return false if userId
		collection.before.update (userId) -> return false if userId
		collection.before.remove (userId) -> return false if userId

		collection.before.insert (userId, doc) ->
			_.extend doc,
				createdAt: new Date()
				timestamp: Date.now()

		collection.before.insert (userId, doc) ->
			if userId
				_.extend doc,
					creatorId: userId

		# server

		if Meteor.isServer

			Meteor.publish collectionName, ->
				exports[_capitalizeCollectionName].find {},
					sort:
						timestamp: -1

			Meteor.publish _singularizeCollectionName, (docId) ->
				check docId, Match.Optional(String)
				exports[_capitalizeCollectionName].find _id: docId

		if Match.isClient

			Router.map ->
				@route ''

		return collection

# collection methods

Meteor.methods

	insert: (collection, doc) ->
		check collection, Match.Optional(String)
		check doc, Match.Optional(Object)
		collection = collection.capitalize()
		exports[collection].insert doc

	update: (collection, docId, doc) ->
		check collection, Match.Optional(String)
		check docId, Match.Optional(String)
		check doc, Match.Optional(Object)
		collection = collection.capitalize()
		exports[collection].update docId, $set: doc

	remove: (collection, docId) ->
		check collection, Match.Optional(String)
		check docId, Match.Optional(String)
		collection = collection.capitalize()
		exports[collection].remove doc
