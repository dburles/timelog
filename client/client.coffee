Session.setDefault('main', true)
Session.setDefault('config', false)

Meteor.autorun ->
	Meteor.subscribe 'log', Meteor.userId()

Template.listing.log = ->
	Log.find {}, sort: { ts: -1 }

Template.info.total = ->	
	@total = 0
	logs = Log.find {}
	logs.forEach (log) ->
		@total += parseFloat log.time
		return
	@total

Template.info.remaining = ->
	if Meteor.user()
		Meteor.user().profile.goal - @total

Template.main_form.events {
	'submit': (e) ->
		e.preventDefault()
		if signed_in()
			add()
}

Template.listing.events {
	'click .delete': (e) ->
		#if confirm "Are you sure?"
		Log.remove { _id: this._id }
}

Template.config.events {
	'submit': (e) ->
		e.preventDefault()
		if signed_in()
			Meteor.users.update(Meteor.userId(), { $set: { profile: { goal: $('#goal').val() } } })
}

Template.nav.events {
	'click #config': (e) ->
		Session.set('main', false)
		Session.set('config', true)
	'click #main': (e) ->
		Session.set('main', true)
		Session.set('config', false)
}

Template.config_form.profile = ->
	if Meteor.user()
		Meteor.user().profile

Template.main.visibility = ->
	if not Session.get('main')
		"invisible"

Template.config.visibility = ->
	if not Session.get('config')
		"invisible"

Template.nav.active_main = ->
	if Session.get('main')
		"active"

Template.nav.active_config = ->
	if Session.get('config')
		"active"


signed_in = ->
	if not Meteor.userId()
		alert "Please sign-in first"
	else
		true

add = ->
	time = $('#time')
	task = $('#task')

	if time.val() and task.val()
		Log.insert {
			user_id: Meteor.userId(),
			time: time.val(),
			task: task.val(),
			ts: (new Date).getTime(),
		}

		time.val ""
		task.val ""
		time.focus()

