Template.fastCommentForm.events
	'submit #fastCommentForm': (e, t) ->
		e.preventDefault()
		options = form2js 'fastCommentForm'
		Meteor.call 'newComment', @_id, options, (err) ->
			unless err
				($ t.find '.reset').trigger 'click'
