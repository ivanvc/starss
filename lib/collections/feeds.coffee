@Feeds = new Meteor.Collection('feeds')

@Feeds.allow
  remove: -> true

Meteor.methods
  feedInsert: (feedAttributes) ->
    check feedAttributes.url, String

    feed = _.extend feedAttributes,
      name: url
      status: 'unknown'
      unreadCount: 0
      lastError: ''
      lastUpdateAt: new Date()
      lastFetchAt: new Date()
      createdAt: new Date()

    if Meteor.isServer
      # TODO: Handle errors, and dups
      remoteAttributes = FeedDiscover.fetch(feed.url)
      _.extend feed, remoteAttributes

    _id: Feeds.insert(feed)

  feedUpdate: (id, feedAttributes) ->
    check(feedAttributes.url, String) if feedAttributes.hasOwnProperty('url')
    check(feedAttributes.name, String) if feedAttributes.hasOwnProperty('name')

    if Meteor.isServer and feedAttributes.hasOwnProperty('url')
      feedAttributes.url = FeedDiscover.fetch(feedAttributes.url).url

    success: Feeds.update(id, { $set: feedAttributes })
