Template.storiesList.helpers
  stories: ->
    Stories.find { readAt: null }, sort: { pubDate: 1 }
