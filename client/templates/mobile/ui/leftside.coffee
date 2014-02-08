Template['mobile-leftside'].rendered = ->
	($ '.logout').on 'tap', ->
		Meteor.logout (err) ->
			unless err
				Router.go Router.routes['mobile-signin'].path()
