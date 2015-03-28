Template.feedItem.helpers
  lastFetch: ->
    moment(@lastFetchAt).format 'lll'
