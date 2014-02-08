Template['backend-notes-item'].events
	'click [data-action="remove"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'removeNote', @_id
