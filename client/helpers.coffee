Template.nav.helpers {
	active_main: ->
		if Session.get('main')
			"active"

	active_config: ->
		if Session.get('config')
			"active"
}

Template.main.helpers {
	visibility: ->
		if not Session.get('main')
			"invisible"
}

Template.listing.helpers {
	log: ->
		Log.find({}, sort: { ts: -1 })
}

Template.info.helpers {
	total: ->	
		@total = 0
		logs = Log.find({})
		logs.forEach (log) ->
			@total += parseFloat log.time
			return
		@total

	remaining: ->
		if Meteor.user() and Meteor.user().hasOwnProperty('profile')
			Meteor.user().profile.goal - @total
		else
			"Please set goal under Config"
}

Template.config.helpers {
	profile: ->
		if Meteor.user()
			Meteor.user().profile

	visibility: ->
		if not Session.get('config')
			"invisible"
}