Log = new Meteor.Collection "log"

Meteor.publish "log", (user_id) ->
	Log.find { user_id: user_id }
