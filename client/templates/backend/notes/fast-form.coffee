Template['backend-notes-fast-form'].events
	'submit form': (e, t) ->
		e.preventDefault()
		options = form2js 'fastNoteForm'
		Meteor.call 'newNote', options, (err) ->
			unless err
				($ t.find '.reset').trigger 'click'
				($ t.find 'textarea').height 'auto'
				($ t.find '#upload-files').empty()
