@Posts = new Meteor.Collection 'posts',
	transform: (post) ->
		_.extend post,
			creator: Users.findOne(post.creatorId) or Users.findOne()
			desc: post.desc or post.content.truncate(160)

Posts.before.insert (userId, post) ->
	_.extend post,
		createdAt: new Date()
		timestamp: Date.now()
		creatorId: userId

Meteor.methods

	newPost: (options) ->
		Posts.insert options

	editPost: (options, postId) ->
		Posts.update postId,
			$set:
				options

	removePost: (postId) ->
		Posts.remove postId

if Meteor.isServer

	Meteor.publish '', ->
		Posts.find {},
			sort:
				timestamp: -1
			limit: 30
