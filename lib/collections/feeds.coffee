@Feeds = new Meteor.Collection('feeds')

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
