Template.storyItem.helpers
  formattedPubDate: ->
    moment(@pubDate).format 'lll'
  isFaved: ->
    if @favedAt is null then 'empty' else 'yellow'
