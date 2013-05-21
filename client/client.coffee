Session.setDefault('main', true)
Session.setDefault('config', false)

Meteor.autorun ->
	Meteor.subscribe('log', Meteor.userId())

@signed_in = ->
	if not Meteor.userId()
		alert "Please sign-in first"
	else
		true
