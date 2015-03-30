discover = Npm.require('feed-discover')
request  = Npm.require('request')

@FeedDiscover =
  fetch: (url, callback) ->
    request(url).
      pipe(discover(url)).
      on('error', (error) ->
        callback null, error
      ).
      on('response', -> console.log('on response')).
      on 'data', (feed) ->
        callback feed.toString()
