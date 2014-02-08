Meteor.startup ->

	isSystemExist = App.isDocExist System, { system: true }

	unless isSystemExist

		System.insert
			system: true
