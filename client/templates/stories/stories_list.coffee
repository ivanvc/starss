Template.storiesList.helpers
  stories: ->
    query = { $or: [{ readAt: null }, { readAt: { $gt: new Date() } }] }
    Stories.find query, sort: { pubDate: 1 }
