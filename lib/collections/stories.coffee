@Stories = new Meteor.Collection('stories')

Meteor.methods
  readStory: (id) ->
    success: Stories.update(id, $set: { readAt: new Date() })

  favStory: (id, faved) ->
    date = faved && new Date() || null
    success: Stories.update(id, $set: { favedAt: date })

  keepUnread: (id, keepUnread) ->
    props = keepUnread: keepUnread
    props.readAt = if keepUnread then null else new Date()
    success: Stories.update(id, $set: props)
