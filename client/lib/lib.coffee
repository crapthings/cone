@setHiddenValue = (selector, value) ->
	selector.val value

@destroyJcropInstance = ->
	if $jcropInstance and $jcropInstance.hasOwnProperty('destroy')
			$jcropInstance.destroy()
	($ '#avatar-crop-container').empty()

@uploadFiles = (evtObj) ->
	files = FileAPI.getFiles evtObj
	_.each files, (file) ->
		FileAPI.upload
			url: 'http://localhost:8081/uploads'
			files:
				file: file
			complete: (err, xhr) ->
				unless err
					filename = EJSON.parse(xhr.response).filename
					$image = ($ '<input type="hidden" name="images[]" />').val filename
					($ '#upload-files').append $image

@uploadImages = (evtObj) ->
	files = FileAPI.getFiles evtObj
	_.each files, (file) ->
		FileAPI.upload
			url: 'http://localhost:8081/api/upload/image'
			files:
				image: file
			complete: (err, xhr) ->
				unless err
					filename = EJSON.parse(xhr.response).filename
					$image = ($ '<input type="hidden" name="images[]" />').val filename
					($ '#upload-files').append $image
