Template.profile.events
	'submit form': (e, t) ->
		e.preventDefault()
		options = form2js 'userProfileForm'
		Meteor.call 'updateUserProfile', options
		($ '#avatar-crop-container').hide()
		if $ias?
			$ias.remove()

	'click #avatar-preview': (e, t) ->
		($ t.find '#avatar-picker').trigger 'click'

	'change #avatar-picker': (e, t) ->
		($ '#avatar-crop-container').show()
		window.$avatar = FileAPI.getFiles(e)
		_.each $avatar, (file) ->
			fileInfo = undefined
			FileAPI.getInfo file, (err, info) ->
				fileInfo = info
			FileAPI.Image(file).get (err, img) ->
				window.$ias = ($ t.find '#avatar-to-crop').html(img).children().imgAreaSelect {
					instance: true
					handles: true
					aspectRatio: "1:1"
					imageWidth: fileInfo.width
					imageHeight: fileInfo.height
				}

	'click #avatar-save': (e, t) ->
		_.each $avatar, (file) ->
			FileAPI.upload
				url: 'http://www.qiuguotongxin.com:8081/api/upload/avatar'
				files:
					image: file
				data: $ias.getSelection()
				complete: (err, xhr) ->
					unless err
						setHiddenValue ($ t.find 'input[name="avatarUrl"]'), (EJSON.parse xhr.response).filename
						($ t.find '#update-user-profile').trigger 'click'
