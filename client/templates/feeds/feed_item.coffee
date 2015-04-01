Template.feedItem.helpers
  lastFetch: ->
    moment(@lastFetchAt).format 'lll'
  statusColor: ->
    switch @status
      when 'good' then 'green'
      when 'unknown' then 'gray'
      when 'bad' then 'red'
