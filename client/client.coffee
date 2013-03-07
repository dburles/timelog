Log = new Meteor.Collection "log"

Meteor.autorun ->
	Meteor.subscribe "log", Meteor.userId()

Template.listing.log = ->
	Log.find {}, sort: { ts: -1 }

Template.form.events {
	'keyup input': (e) ->
		if e.which is 13
			add()
	'click #add': (e) ->
		add()
}

Template.listing.events {
	'click .delete': (e) ->
		#if confirm "Are you sure?"
		Log.remove { _id: $(e.target).attr('data-id') }
}

add = ->
	if not Meteor.userId()
		alert "Please sign-in first"
	else
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