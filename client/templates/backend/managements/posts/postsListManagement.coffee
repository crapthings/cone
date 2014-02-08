Template.postItemManagement.events
	'click .remove': (e, t) ->
		cfm = confirm "确定要删除\n\n#{@title}"
		if cfm
			Meteor.call 'removePost', @_id
