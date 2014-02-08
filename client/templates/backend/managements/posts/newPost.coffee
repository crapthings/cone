Template.newPost.events
	'submit form': (e, t) ->
		options = form2js 'postForm'
		Meteor.call 'newPost', options, (err) ->
			Router.go Router.routes['postsManagement'].path()
