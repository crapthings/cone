Template.editPost.events
	'submit #postForm': (e, t) ->
		options = form2js 'postForm'
		Meteor.call 'editPost', options, @_id, (err) ->
			unless err
				Router.go Router.routes['postsManagement'].originalPath
