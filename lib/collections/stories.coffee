@Stories = new Meteor.Collection('stories')

Meteor.methods
  readStory: (id) ->
    success: Stories.update(id, $set: { readAt: new Date() })

  favStory: (id, faved) ->
    date = faved && new Date() || null
    success: Stories.update(id, $set: { favedAt: date })
