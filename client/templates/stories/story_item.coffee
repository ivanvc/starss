BLACKLISTED_TAGS = ['b', 'i', 'strong', 'em', 'blockquote', 'ol', 'ul', 'li',
                    'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'h7', 'p', 'span',
                    'pre', 'a', 'u', 'img', 'br', 'table']

StoryItem =
  hideStory: ($target) ->
    window.location.hash = ''
    $target.removeClass('raised current').addClass 'preview'

  showStory: ($target) ->
    window.location.hash = $target.prop('id')
    $('.stories .story').removeClass('raised current').
      addClass 'secondary preview'
    $target.removeClass('secondary preview').addClass 'raised current'
    return if @readAt or @keepUnread
    Meteor.call 'readStory', $target.prop('id'), (error, result) ->
      console.log(error) if error

@StoryItem = StoryItem

Template.storyItem.onRendered ->
  $node = $(@firstNode)
  $('.ui.rating', $node).rating
    clearable: true
    onRate: (rate) ->
      Meteor.call 'favStory', @dataset.id, rate, (error, result) ->
        console.log(error) if error
  $('.full-text a', $node).prop 'target', '_blank'

Template.storyItem.helpers
  formattedPubDate: ->
    moment(@pubDate).format 'lll'
  isFaved: ->
    @favedAt && 1 || 0
  previewText: ->
    UniHTML.purify @description,
      withoutTags: BLACKLISTED_TAGS, noFormatting: true
  cssClass: ->
    switch
      when window.location.hash.substr(1) is @_id then return 'raised'
      when @keepUnread then return 'primary blue'
      when !@readAt then return 'primary'
      when @favedAt and @readAt then return 'secondary'
      when @readAt then return 'tertiary'
  keepUnreadId: ->
    @unreadId ?= _.uniqueId()

Template.storyItem.events
  'click .story-title': (e) ->
    return if $(e.target).hasClass('icon')
    $target = $(e.currentTarget).parents('.story')
    if $target.hasClass('current')
      StoryItem.hideStory $target
    else
      StoryItem.showStory.call @, $target
  'change .keep-unread': (e) ->
    Meteor.call 'keepUnread', @_id, e.target.checked, (error, result) ->
      console.log(error) if error
