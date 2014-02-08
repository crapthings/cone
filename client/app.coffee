# init router

Router.configure
	layoutTemplate: 'layout'

Router.before(->
	unless Meteor.user()
		Router.go Router.routes['backend-signin'].path()
		@stop()
, {
	except: [
		'website-home',
		'backend-signin',
		'backend-signup',
		'mobile-signin'
	]
})

Meteor.startup ->
	$niceScroll = false
