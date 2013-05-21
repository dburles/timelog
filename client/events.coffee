Template.main.events {
	'submit': (e) ->
		e.preventDefault()
		if signed_in()
			time = $('#time')
			task = $('#task')

			if time.val() and task.val()
				Meteor.call('create', { time: time.val(), task: task.val() })

				time.val ""
				task.val ""
				time.focus()
}

Template.listing.events {
	'click .delete': (e) ->
		#if confirm "Are you sure?"
		Meteor.call('remove', this._id)
}

Template.config.events {
	'submit': (e) ->
		e.preventDefault()
		if signed_in()
			Meteor.call('update_config', $('#goal').val())
}

Template.nav.events {
	'click #config': (e) ->
		Session.set('main', false)
		Session.set('config', true)
	'click #main': (e) ->
		Session.set('main', true)
		Session.set('config', false)
}