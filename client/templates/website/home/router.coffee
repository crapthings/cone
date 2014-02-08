Router.map ->
	@route 'website-home',
		path: '/'
		layoutTemplate: 'website-layout'
		data: ->
			recentPostsList: Posts.find {},
				sort:
					timestamp: -1
				limit: 3
