Template.fastTaskForm.events
	'keypress [name="content"]': (e, t) ->
		if e.keyCode is 13 and e.shiftKey
			($ t.find 'input[type="submit"]').trigger 'click'

	'submit #fastTaskForm': (e, t) ->
		e.preventDefault()
		options = form2js 'fastTaskForm'
		Meteor.call 'newTask', options, (err) ->
			($ t.find '.reset').trigger 'click'
			($ t.find 'textarea').height 'auto'
			($ t.find '#upload-files').empty()

	'click #btn-pick-images': (e, t) ->
		($ t.find '#images-picker').trigger 'click'

	'click #btn-pick-files': (e, t) ->
		($ t.find '#files-picker').trigger 'click'

	'change #images-picker': (e, t) ->
		uploadImages e

	'change #files-picker': (e, t) ->
		uploadFiles e
