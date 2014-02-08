Router.map ->
	@route 'mobile-signin',
		layoutTemplate: 'mobile-signin-layout'
		path: '/mobile/signin'
		before: [
			->
				if Meteor.user()
					Router.go Router.routes['mobile-home'].path()
					@stop()
		]
