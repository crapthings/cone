Router.map ->
	@route 'backend-my',
		path: '/backend/my'

		data: ->
			page:
				title: '我的'

			myLatestNotes: Notes.find {},
				sort:
					timestamp: -1

		before: [
			->
				@subscribe('myLatestNotes').wait()
		]
