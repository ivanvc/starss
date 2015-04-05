FeedParser = Npm.require('feedparser')

@FeedFetcher = class FeedFetcher
  constructor: (@feed) ->

  fetch: ->
    response = HTTP.get(@feed.url)
    if response.statusCode is 200 then @clearError() else @setError(response)

  clearError: ->
    @updateFeed lastError: null, status: 'good'

  setError: (response) ->
    error = "[#{response.statusCode}] #{response.content}"
    @updateFeed lastError: error, status: 'bad'

  updateFeed: (properties) ->
    properties.lastFetchAt = new Date()
    Feeds.update @feed._id, $set: properties

@FeedFetcher.fetchAll = ->
  for feed in Feeds.find().fetch()
    new FeedFetcher(feed).fetch()
