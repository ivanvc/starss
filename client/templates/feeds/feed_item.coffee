Template.feedItem.helpers
  lastFetch: ->
    moment(@lastFetchAt).format 'lll'
  statusColor: ->
    switch @status
      when 'good' then 'green'
      when 'unknown' then 'gray'
      when 'bad' then 'red'

Template.feedItem.events
  'click .delete': (e) ->
    e.preventDefault()

    if confirm(TAPi18n.__('feed_item_confirm_delete'))
      Feeds.remove @_id
