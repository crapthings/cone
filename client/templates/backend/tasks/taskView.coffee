Template.taskView.events
	'click .markTaskAsCompleted': (e, t) ->
		Meteor.call 'completeTask', @_id

Template.taskView.rendered = ->
	$niceScroll = ($ '.task-images-wrapper').niceScroll() if ($ '.task-images-wrapper').length
