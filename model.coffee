@Log = new Meteor.Collection "log"

Log.allow {
	insert: (userId, doc) ->
		userId && doc.user_id == userId
	update: (userId, doc) ->
		userId == doc.user_id
	remove: (userId, doc) ->
		userId == doc.user_id
	fetch: ['user_id']
}

Meteor.methods {
	'create': (data) ->
		data.ts = (new Date).getTime()
		data.user_id = @userId
		Log.insert(data)
	'remove': (logId) ->
		Log.remove(logId)
	'update_config': (goal) ->
		Meteor.users.update(Meteor.userId(), { $set: { profile: { goal: goal } } })
}