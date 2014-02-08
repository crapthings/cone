Template.userItem.events
	'click .remove': (e, t) ->
		Meteor.call 'removeUser', @_id
