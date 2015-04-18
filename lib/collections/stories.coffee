@Stories = new Meteor.Collection('stories')

Meteor.methods
  readStory: (id) ->
    success: Stories.update(id, $set: { readAt: new Date() })
