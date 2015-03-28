if Feeds.find().count() is 0
  now = new Date().getTime()

  Feeds.insert
    name: 'The Changelog'
    url: 'http://thechangelog.com/feed/'
    status: 'good'
    lastFetchAt: new Date(now - 1 * 3600 * 1000)
    createdAt: new Date(now - 2 * 3600 * 1000)

  Feeds.insert
    name: 'One Ting Well'
    url: 'http://onethingwell.org/rss'
    status: 'good'
    lastFetchAt: new Date(now - 1 * 3600 * 1000)
    createdAt: new Date(now - 3 * 3600 * 1000)
