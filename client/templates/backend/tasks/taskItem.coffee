Template.taskItem.events
	'click [data-action="complete"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'completeTask', @_id

	'click [data-action="uncomplete"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'uncompleteTask', @_id

	'click [data-action="urgency"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'urgencyTask', @_id

	'click [data-action="unurgency"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'unurgencyTask', @_id

	'click [data-action="close"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'closeTask', @_id

	'click [data-action="unclose"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'uncloseTask', @_id

	'click [data-action="remove"]': (e, t) ->
		e.preventDefault()
		Meteor.call 'removeTask', @_id

Template.taskItem.spent = (a, b) -> moment(b).from(a)
