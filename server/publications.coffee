Meteor.publish 'feeds', ->
  Feeds.find {}

Meteor.publish 'singleFeed', (id) ->
  check id, String
  Feeds.find id

Meteor.publish 'stories', (findOptions, extraOptions) ->
  extraOptions ?= {}
  Stories.find findOptions, extraOptions
