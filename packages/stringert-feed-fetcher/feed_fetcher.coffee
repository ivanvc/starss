FeedParser = Npm.require('feedparser')
Request    = Npm.require('request')
Fiber      = Npm.require('fibers')

@FeedFetcher = class FeedFetcher
  constructor: (@feed) ->
    that = @
    @feedParser = new FeedParser()
    @feedParser.on 'error', => new Fiber(=> @setError(error)).run()
    @feedParser.on 'readable', ->
      new Fiber(=>
        that.processStory(story) while story = @read()
      ).run()

  fetch: ->
    that = @
    request = Request(@feed.url)
    request.on 'error', Meteor.bindEnvironment (error) =>
      @setError(error)
    request.on 'response', (response) ->
      unless response.statusCode is 200
        return that.setError("[#{response.statusCode}] #{response.content}")
      that.clearError()
      @pipe(that.feedParser)

  clearError: ->
    @updateFeed lastError: null, status: 'good'

  setError: (message) ->
    @updateFeed lastError: message, status: 'bad'

  updateFeed: (properties) ->
    new Fiber(=>
      properties.lastFetchAt = new Date()
      Feeds.update @feed._id, $set: properties
    ).run()

  processStory: (story) ->
    return if Stories.findOne(feedId: @feed._id, guid: story.guid)
    Stories.insert
      title: story.title
      pubDate: story.pubdate
      description: story.description
      link: story.link
      guid: story.guid
      feedId: @feed._id
      feedName: @feed.name
      readAt: null
      favedAt: null
      keepUnread: false
      createdAt: new Date()

@FeedFetcher.fetchAll = ->
  for feed in Feeds.find().fetch()
    new FeedFetcher(feed).fetch()
