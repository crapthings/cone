Template.postForm.events
	'click #btn-pick-images': (e, t) ->
		($ t.find '#images-picker').trigger 'click'

	'click #btn-pick-files': (e, t) ->
		($ t.find '#files-picker').trigger 'click'

	'change #images-picker': (e, t) ->
		uploadFiles e

	'change #files-picker': (e, t) ->
		uploadFiles e
