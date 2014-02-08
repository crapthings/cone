Template.fastPostForm.events
	'submit #fastPostForm': (e, t) ->
		e.preventDefault()
		options = form2js 'fastPostForm'
		Meteor.call 'newPost', options, (err) ->
			unless err
				App.resetForm(t)

	'click #btn-pick-images': (e, t) ->
		($ t.find '#images-picker').trigger 'click'

	'click #btn-pick-files': (e, t) ->
		($ t.find '#files-picker').trigger 'click'

	'change #images-picker': (e, t) ->
		uploadFiles e

	'change #files-picker': (e, t) ->
		uploadFiles e
