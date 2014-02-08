Router.map ->
	@route 'postsManagement',
		path: '/backend/managements/posts'

		data: ->
			postsList: Posts.find {},
				sort:
					timestamp: -1

	@route 'newPost',
		path: '/backend/managements/posts/new'

	@route 'editPost',
		path: '/backend/managements/posts/:_id/edit'

		data: ->
			post: Posts.findOne @params._id
