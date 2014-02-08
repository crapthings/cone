Helper = Handlebars.registerHelper

Helper 'timeago', (date) ->
	return moment(date).format()

Helper 'uploads', (filename) ->
	return "http://www.qiuguotongxin.com:8081/uploads/#{filename}"

Helper 'imagesPath', (filename) ->
	return "http://www.qiuguotongxin.com:8081/uploads/#{filename}"

Helper 'system', -> System.findOne { system: true }

Helper 'randomImage', ->
	if @images and @images.length
		return @images.sample()

Helper 'activeFor', (path) ->
	return 'active'	if Router.current().route.name is path

Helper 'usersOnline', ->
	Users.find {},
		sort:
			online: true
			username: true
